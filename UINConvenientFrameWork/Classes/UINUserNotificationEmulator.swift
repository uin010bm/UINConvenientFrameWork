// 
//  UINUserNotificationEmulator.swift
//  Pods
//
//  Created by yu tanaka on 2018/08/24.
//  Copyright (c) 2018年 CyberAgent, Inc. All rights reserved.
//


import UIKit
import UserNotifications

/// user notification center presenter
@available(iOS 10.0, *)
public class UINUserNotificationEmulator {
    
    /// fire user notification
    ///
    /// - Parameters:
    ///   - title: title string
    ///   - body: description string
    ///   - badge: badge count
    ///   - timing: time interval
    public static func sendSampleNotification(title: String, body: String, badge: Int, timing: TimeInterval) {
        
        let obj: [AnyHashable : Any] = [
            "aps": [
                "title": "\(title)",
                "body": "\(body)"
            ],
            "badge" : "\(badge)"
        ]

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.userInfo = obj

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timing, repeats: false)
        
        let requestIdentifier = "\(trigger.hashValue)"
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {
            (error) in
            guard let e = error else { return }
            print(e)
        }
    }
}
