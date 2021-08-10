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
        super.init(contentRect: contentRect, styleMask: [.borderless, .titled, .fullSizeContentView], backing: .buffered, defer: false)
        
        self.backgroundColor = .clear
        self.isOpaque = false
        self.isMovableByWindowBackground = true
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        
        // Allow the panel to appear in a fullscreen space
        self.collectionBehavior.insert(.fullScreenAuxiliary)
        self.collectionBehavior.insert(.canJoinAllSpaces)
    }
    
    // `canBecomeKey` and `canBecomeMain` are required so that text inputs inside the panel can receive focus
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return true
    }
}
