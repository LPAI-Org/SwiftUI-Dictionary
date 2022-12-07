//Local Notifications happens on the devices and it gets rendered based on a certain events. Example of local notifications is a notifications that happens on a cron job that we have scheduled, in a case where every Monday they get a notification reminder etc.
//A non-local notification would be coming from a server, whereas someone would like a picture, or commented on a picture and those get sent to a server so it can redirect to the appropriate user that needs to get notified

import SwiftUI
///In order to use push notifications we need to import the framework UserNotifications
import UserNotifications
import CoreLocation


class NotificationManager {
    static let instance = NotificationManager() // Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [
            .alert, .sound, .badge]
        //typically when you create a UserNotification, when the request is successful you want to do something, but in our case we are only printing out the success/error
        UNUserNotificationCenter.current().requestAuthorization(options: options)
        { success, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("SUCCESS!")
            }
            
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first Notification"
        content.subtitle = "This was so easy!"
        content.sound = .default
        content.badge = 1
        
    //MARK: Three ways to approach a notification to the user (Time/Calendar/Location)
        ///- Time:
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        ///- Calendar:
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 7
//        dateComponents.minute = 36
//        dateComponents.weekday = 2
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        ///- Location:
        //CLLocationCoordinate2D: setting the coordinates where you want the user to be triggered if they walked into this location
//        let coordinates = CLLocationCoordinate2D(latitude: 26.622010, longitude: -80.182050)
//        //CLCircularRegion: takes in the parameters where you want the notification to trigger based on the region below.
//        let region = CLCircularRegion(
//            //center takes in the coordinates we created
//            center: coordinates,
//            //radius in meters you want the circumference of the location to trigger
//            radius: 50,
//            //identifier is an ID that would get generated based on this trigger for tracking purposes
//            identifier: UUID().uuidString)
//        //notify when entered into that region created above
//        region.notifyOnEntry = true
//        //notification on exit, if you want to notify the user on anything when they leave a certain location
//        region.notifyOnExit = false
//        //UNLocationNotificationTrigger takes in the parameters we created above
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        //removeAllPendingNotificationRequests removes all pending notifications that have not come in yet
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        //removeAllDeliveredNotifications removes all notifications that are on the phone for this app
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct LocalNotifications: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
                
            }
            Divider()
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
                
            }
            Divider()
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
                
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotifications_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotifications()
    }
}
