import Foundation
import UserNotifications

final class NotificationService: NSObject, ObservableObject {
    @Published private(set) var authorizationStatus: UNAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func refreshAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                self?.authorizationStatus = settings.authorizationStatus
            }
        }
    }

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] _, _ in
            self?.refreshAuthorizationStatus()
        }
    }

    func sendGeofenceNotification(for club: Club) {
        let content = UNMutableNotificationContent()
        content.title = "You're near \(club.name)"
        content.body = "Drop by \(club.meetingPlace) or save the next event."
        content.sound = .default
        content.attachments = notificationLogoAttachment()

        let request = UNNotificationRequest(
            identifier: "club-geofence-\(club.id.uuidString)",
            content: content,
            trigger: nil
        )
        UNUserNotificationCenter.current().add(request)
    }

    private func notificationLogoAttachment() -> [UNNotificationAttachment] {
        guard let logoURL = Bundle.main.url(forResource: "notification-logo", withExtension: "png"),
              let attachment = try? UNNotificationAttachment(identifier: "notification-logo", url: logoURL)
        else {
            return []
        }

        return [attachment]
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
