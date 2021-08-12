//
//  AppDelegate.swift
//  Palette
//
//  Created by Ashwin on 27/07/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var mainPanel: MainPanel?
    lazy var mainPanelController = MainPanelController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.showMainPanel()
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func showMainPanel() {
        mainPanelController.window?.makeKeyAndOrderFront(nil)
        mainPanelController.window?.orderFrontRegardless()
        mainPanelController.showWindow(nil)
    }
}

