//
//  AppDelegate.swift
//  Palette
//
//  Created by Ashwin on 27/07/21.
//

import Cocoa
import KeyboardShortcuts

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    lazy var mainPanelController = MainPanelController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.showMainPanel()
        
        KeyboardShortcuts.onKeyUp(for: .toggleMainPanelVisibility) {
            if(self.mainPanelController.window?.isVisible == true) {
                self.mainPanelController.window?.close()
            } else {
                self.mainPanelController.window?.makeKeyAndOrderFront(nil)
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func showMainPanel() {
        mainPanelController.showWindow(nil)
    }
}

