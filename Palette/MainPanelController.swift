//
//  MainPanelController.swift
//  Palette
//
//  Created by Ashwin on 11/08/21.
//

import Cocoa

class MainPanelController: NSWindowController {
    convenience init() {
        // A window nib name needs to be passed to the initialiser for the window controller to call the loadWindow method below. Doing this ensures that the windowDidLoad method is called only when showWindow() is called at the call-site.
        // References:
        // https://youtu.be/vcyA4vTwZcQ?t=879
        // https://github.com/lucasderraugh/AppleProg-Cocoa-Tutorials/blob/master/Lesson%2069/Lesson%2069/CodeWindowController.swift
        self.init(windowNibName: "")
    }
    
    override func loadWindow() {
        self.window = MainPanel(contentRect: NSRect(x: 0, y: 0, width: 683, height: 400))
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"),bundle: nil)
        contentViewController = storyboard.instantiateController(withIdentifier: "MainViewController") as? NSViewController
    }

}
