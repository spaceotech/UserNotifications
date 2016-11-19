//
//  ViewController.swift
//  SOUserNotifications
//
//  Created by Hitesh on 11/19/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().delegate = self
        
        authorizeNotification()
    }
    
    
    //Authorization for Local Notification
    func authorizeNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Error:- \(error)")
            } else if success == true {
                print("Permission Granted")
            }
        }
    }
    
    @IBAction func scheduleNotification() {
        
        // Adding Action
        let likeAction = UNNotificationAction(identifier: "LikeID",
                                                title: "Like", options: [.foreground])
        let dislikeAction = UNNotificationAction(identifier: "DislikeID",
                                                title: "Dislike", options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "app.likedislike.ios10",
                                              actions: [likeAction, dislikeAction],
                                              intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "iOS 10 UserNotifications"
        notificationContent.subtitle = "Local Notifications"
        notificationContent.body = "The UserNotifications framework (UserNotifications.framework) supports the delivery and handling of local and remote notifications."
        notificationContent.categoryIdentifier = "app.likedislike.ios10"
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)

        // Create Notification Request
        let request = UNNotificationRequest(identifier: "app.likedislike.ios10",
                                            content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("Error \(error)")
                // Something went wrong
            }
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

