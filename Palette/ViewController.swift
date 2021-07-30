//
//  ViewController.swift
//  Palette
//
//  Created by Ashwin on 27/07/21.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
//    let fileSearch = FileSearch()
    @IBOutlet weak var paletteTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paletteTextField.delegate = self
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField, self.paletteTextField.identifier == textField.identifier {
//            fileSearch.updateQueryString(to: textField.stringValue)
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

