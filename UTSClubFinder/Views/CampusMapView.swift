import MapKit
import SwiftUI

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
                UserAnnotation()

                ForEach(repository.clubs) { club in
                    Marker(club.name, systemImage: club.category.icon, coordinate: club.coordinate)
                        .tint(AppTheme.utsGreen)
                        .tag(club)
                }
            }
            .mapControls {
                MapUserLocationButton()
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
        .sheet(item: $selectedClub) { club in
            NavigationStack {
                ClubDetailView(club: club)
            }
            .presentationDetents([.medium, .large])
        }
    }

    private var controlPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Geofence alerts")
                        .font(.headline)
                    Text(statusText)
                        .font(.caption)
                        .foregroundStyle(AppTheme.muted)
                }
                Spacer()
                Image(systemName: "location.fill")
                    .foregroundStyle(AppTheme.utsGreen)
            }

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
                }
                .buttonStyle(.borderedProminent)

                Button {
                    if let club = selectedClub ?? repository.clubs.first {
                        geofenceManager.simulateEntry(for: club, notificationService: notificationService)
                    }
                } label: {
                    Label("Demo", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(16)
        .background(Color.white)
    }

    private var statusText: String {
        if geofenceManager.monitoredClubIDs.isEmpty {
            return "Enable alerts to monitor nearby club locations."
        }
        return "Monitoring \(geofenceManager.monitoredClubIDs.count) club regions."
    }
}
