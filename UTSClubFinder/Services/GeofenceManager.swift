import CoreLocation
import Foundation

final class GeofenceManager: NSObject, ObservableObject {
    @Published private(set) var authorizationStatus: CLAuthorizationStatus
    @Published private(set) var monitoredClubIDs: Set<Club.ID> = []
    @Published var lastEnteredClubID: Club.ID?
    @Published var locationErrorMessage: String?

    private let manager: CLLocationManager
    private var clubsByRegionID: [String: Club] = [:]
    weak var notificationService: NotificationService?

    override init() {
        let locationManager = CLLocationManager()
        self.manager = locationManager
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    var canMonitorGeofences: Bool {
        CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
    }

    func requestLocationAccess() {
        manager.requestAlwaysAuthorization()
    }

    func startMonitoring(clubs: [Club], notificationService: NotificationService) {
        self.notificationService = notificationService
        locationErrorMessage = nil

        guard canMonitorGeofences else {
            locationErrorMessage = "Geofencing is not available on this device."
            return
        }

        guard authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse else {
            requestLocationAccess()
            return
        }

        stopMonitoring()

        for club in clubs.prefix(20) {
            let regionID = club.id.uuidString
            let region = CLCircularRegion(center: club.coordinate, radius: club.geofenceRadius, identifier: regionID)
            region.notifyOnEntry = true
            region.notifyOnExit = false
            clubsByRegionID[regionID] = club
            manager.startMonitoring(for: region)
            monitoredClubIDs.insert(club.id)
        }
    }

    func stopMonitoring() {
        for region in manager.monitoredRegions {
            manager.stopMonitoring(for: region)
        }
        monitoredClubIDs.removeAll()
        clubsByRegionID.removeAll()
        locationErrorMessage = nil
    }

    func simulateEntry(for club: Club, notificationService: NotificationService) {
        lastEnteredClubID = club.id
        notificationService.sendGeofenceNotification(for: club)
    }
}

extension GeofenceManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
                self.locationErrorMessage = "Location permission is off. Enable it in Settings to test live geofence alerts."
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let club = clubsByRegionID[region.identifier] else { return }

        DispatchQueue.main.async {
            self.lastEnteredClubID = club.id
            self.notificationService?.sendGeofenceNotification(for: club)
        }
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        DispatchQueue.main.async {
            self.locationErrorMessage = error.localizedDescription
        }
    }
}
