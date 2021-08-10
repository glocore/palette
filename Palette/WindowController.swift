//
//  WindowController.swift
//  Palette
//
//  Created by Ashwin on 08/08/21.
//

import Cocoa

class WindowController: NSWindowController {
    var count = 0
    var mainPanel: MainPanel?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        mainPanel = MainPanel(contentRect: NSRect(x: 0, y: 0, width: 683, height: 400))
        
        let mainViewController = storyboard?.instantiateController(withIdentifier: "MainViewController") as! NSViewController
        mainPanel?.contentViewController = mainViewController
        
        // Shows the panel and makes it active
        mainPanel!.makeKeyAndOrderFront(nil)
        mainPanel?.center()
        
        
        mainPanel?.setFrameOrigin(NSPoint(x: 500, y: 500))
    }
    
}
