//
//  MainPanelController.swift
//  Palette
//
//  Created by Ashwin on 09/08/21.
//

import Cocoa

class MainPanel: NSPanel {
    // Reference: https://gist.github.com/jordibruin/8ae7b79a1c0ce2c355139f29990d5702
    init(contentRect: NSRect) {
        super.init(contentRect: contentRect, styleMask: [.fullSizeContentView, .titled, .nonactivatingPanel], backing: .buffered, defer: false)
        
        self.backgroundColor = .clear
        self.isOpaque = false
        self.isMovableByWindowBackground = true
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        self.isFloatingPanel = true
        // Allow the panel to appear in a fullscreen space
        self.collectionBehavior.insert(.fullScreenAuxiliary)
        self.collectionBehavior.insert(.canJoinAllSpaces)
        
        self.delegate = self
    }
    
    // `canBecomeKey` and `canBecomeMain` are required so that text inputs inside the panel can receive focus
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
}

extension MainPanel: NSWindowDelegate {
    // Responds to when the mouse is clicked outside the panel.
    func windowDidResignKey(_ notification: Notification) {
        self.close()
    }
    
    // Responds to the Escape and Command+. (period) keys.
    override func cancelOperation(_ sender: Any?) {
        close()
    }
}
