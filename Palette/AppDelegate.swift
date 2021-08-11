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
        
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self = self] in
            self?.showPanel()
        }
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func showPanel() {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"),bundle: nil)
        
        let mainPanelController = storyboard.instantiateController(withIdentifier: "MainPanel") as! NSWindowController
        
        
        mainPanelController.showWindow(nil)
        mainPanelController.window?.makeKeyAndOrderFront(nil)
        mainPanelController.window?.orderFrontRegardless()
        
    }
    
    func preferencesWindow() {
        var mainWindow: NSWindow? = nil
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"),bundle: nil)
        let mainViewController = storyboard.instantiateController(withIdentifier: "MainViewController") as! NSViewController
        mainWindow = MainPanel(contentRect: NSRect(x: 0, y: 0, width: 683, height: 400))
        NSApp.activate(ignoringOtherApps: true)
        mainWindow?.contentViewController = mainViewController
        mainWindow?.makeKeyAndOrderFront(self)
        mainPanel?.orderFrontRegardless()
        let wc = NSWindowController(window: mainWindow)
        wc.showWindow(self)
    }
}

