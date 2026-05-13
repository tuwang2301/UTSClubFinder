import MapKit
import SwiftUI
import UserNotifications

struct CampusMapView: View {
    @EnvironmentObject private var repository: ClubRepository
    @EnvironmentObject private var geofenceManager: GeofenceManager
    @EnvironmentObject private var notificationService: NotificationService

    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -33.8836, longitude: 151.2005),
            span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
        )
    )
    @State private var selectedClub: Club?

    var body: some View {
        VStack(spacing: 0) {
            Map(position: $cameraPosition, selection: $selectedClub) {
                if canShowUserLocation {
                    UserAnnotation()
                }

                ForEach(repository.clubs) { club in
                    Marker(club.name, systemImage: club.category.icon, coordinate: club.coordinate)
                        .tint(AppTheme.utsGreen)
                        .tag(club)
                }
            }
            .mapControls {
                if canShowUserLocation {
                    MapUserLocationButton()
                }
                MapCompass()
                MapScaleView()
            }

            controlPanel
        }
        .navigationTitle("Campus Map")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            notificationService.refreshAuthorizationStatus()
        }
    }

    private var controlPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            permissionStatus
            selectedClubPreview

            if let message = geofenceManager.locationErrorMessage {
                Text(message)
                    .font(.caption)
                    .foregroundStyle(.red)
            }

            HStack(spacing: 10) {
                Button {
                    notificationService.requestAuthorization()
                    geofenceManager.startMonitoring(clubs: repository.clubs, notificationService: notificationService)
                } label: {
                    Label("Enable", systemImage: "bell.badge.fill")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(geofenceManager.canMonitorGeofences ? AppTheme.utsGreen.opacity(0.14) : AppTheme.surface)
                        .foregroundStyle(AppTheme.ink)
                        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
                }
                .buttonStyle(.plain)
                .disabled(!geofenceManager.canMonitorGeofences)

                Button {
                    if let club = selectedClub ?? repository.clubs.first {
                        geofenceManager.simulateEntry(for: club, notificationService: notificationService)
                    }
                } label: {
                    Label("Test Alert", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(AppTheme.utsGreen.opacity(0.12))
                        .foregroundStyle(AppTheme.ink)
                        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
                }
                .buttonStyle(.plain)
            }

            Button {
                geofenceManager.stopMonitoring()
            } label: {
                Label("Stop alerts", systemImage: "bell.slash.fill")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(geofenceManager.monitoredClubIDs.isEmpty ? AppTheme.surface : Color.white)
                    .foregroundStyle(geofenceManager.monitoredClubIDs.isEmpty ? AppTheme.muted : AppTheme.ink)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                            .stroke(AppTheme.line, lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
            }
            .buttonStyle(.plain)
            .disabled(geofenceManager.monitoredClubIDs.isEmpty)
        }
        .padding(16)
        .padding(.bottom, 16)
        .background(Color.white)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Campus geofence alerts")
                    .font(.headline)
                    .foregroundStyle(AppTheme.ink)
                Text(statusText)
                    .font(.caption)
                    .foregroundStyle(AppTheme.ink)
            }
            Spacer()
            Image(systemName: geofenceManager.monitoredClubIDs.isEmpty ? "location" : "location.fill")
                .foregroundStyle(AppTheme.utsGreen)
                .font(.title3)
        }
    }

    private var permissionStatus: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                StatusPill(title: locationPermissionText, systemImage: "location.fill", isReady: canShowUserLocation)
                StatusPill(title: notificationPermissionText, systemImage: "bell.fill", isReady: canSendNotifications)
            }

            Text("Enable alerts to monitor UTS club locations. Test Alert sends the same notification that would appear when entering the selected club's geofence.")
                .font(.caption)
                .foregroundStyle(AppTheme.ink)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    @ViewBuilder
    private var selectedClubPreview: some View {
        if let selectedClub {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: selectedClub.category.icon)
                    .foregroundStyle(AppTheme.utsGreen)
                    .frame(width: 34, height: 34)
                    .background(AppTheme.utsGreen.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))

                VStack(alignment: .leading, spacing: 4) {
                    Text(selectedClub.name)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppTheme.ink)
                    Text(selectedClub.meetingPlace)
                        .font(.caption)
                        .foregroundStyle(AppTheme.ink)
                }

                Spacer()

                NavigationLink {
                    ClubDetailView(club: selectedClub)
                } label: {
                    Text("Details")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(AppTheme.ink)
                }
                .buttonStyle(.bordered)
            }
            .padding(12)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        }
    }

    private var statusText: String {
        guard geofenceManager.canMonitorGeofences else {
            return "Geofencing is unavailable on this device."
        }
        if geofenceManager.monitoredClubIDs.isEmpty {
            return "No active regions. Select Enable to start monitoring."
        }
        if let lastEnteredClubID = geofenceManager.lastEnteredClubID,
           let club = repository.club(withID: lastEnteredClubID) {
            return "Test alert sent for \(club.name)."
        }
        return "Monitoring \(geofenceManager.monitoredClubIDs.count) club regions."
    }

    private var canShowUserLocation: Bool {
        geofenceManager.authorizationStatus == .authorizedAlways
            || geofenceManager.authorizationStatus == .authorizedWhenInUse
    }

    private var canSendNotifications: Bool {
        notificationService.authorizationStatus == .authorized
            || notificationService.authorizationStatus == .provisional
            || notificationService.authorizationStatus == .ephemeral
    }

    private var locationPermissionText: String {
        switch geofenceManager.authorizationStatus {
        case .authorizedAlways:
            return "Location Always"
        case .authorizedWhenInUse:
            return "Location While Using"
        case .denied, .restricted:
            return "Location Denied"
        case .notDetermined:
            return "Location Needed"
        @unknown default:
            return "Location Unknown"
        }
    }

    private var notificationPermissionText: String {
        switch notificationService.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return "Notifications On"
        case .denied:
            return "Notifications Off"
        case .notDetermined:
            return "Notifications Needed"
        @unknown default:
            return "Notifications Unknown"
        }
    }
}

private struct StatusPill: View {
    let title: String
    let systemImage: String
    let isReady: Bool

    var body: some View {
        Label(title, systemImage: systemImage)
            .font(.caption.weight(.semibold))
            .foregroundStyle(AppTheme.ink)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(isReady ? AppTheme.utsGreen.opacity(0.10) : AppTheme.surface)
            .clipShape(Capsule())
    }
}
