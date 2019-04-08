//
//  AppDelegate.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        guard let url = urls.first?.absoluteString else { return }
        // From today extension
        if url.hasPrefix("ZDailyTodayExtension") {
            guard let id = url.components(separatedBy: "/").last else {
                return
            }
            guard let id_num = Int(id) else {
                return
            }
            
            NotificationCenter.default.post(name: Notis.name.TodayExtensionCallbackNotification, object: ["id": id_num])
        }
    }

}

