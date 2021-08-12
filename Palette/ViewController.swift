//
//  ViewController.swift
//  Palette
//
//  Created by Ashwin on 27/07/21.
//

import Cocoa

class FileSearchResult: NSObject {
    @objc dynamic var value: String
    
    init(value: String) {
        self.value = value
    }
}

class ViewController: NSViewController, NSTextFieldDelegate {
    var mdqSearch: MDQSearch?
    @objc dynamic var fileSearchResults = [String]()
    
    @IBOutlet var fileResultsArrayController: NSArrayController!
    @IBOutlet weak var paletteTextField: NSTextField!
    @IBOutlet weak var resultsTable: NSTableView!
    @IBOutlet weak var resultsScrollView: NSScrollView!
    @IBOutlet var visualEffectView: NSVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.state = .active
        visualEffectView.wantsLayer = true
        visualEffectView.layer?.cornerRadius = 16.0
        paletteTextField.delegate = self
        mdqSearch = MDQSearch(onResultsUpdate: self.resultsUpdateHandler)
        paletteTextField.backgroundColor = .clear
        paletteTextField.isBezeled = false
        paletteTextField.drawsBackground = false
        paletteTextField.layer?.cornerRadius = 10
        
        resultsTable.backgroundColor = .clear
        resultsTable.enclosingScrollView?.backgroundColor = .clear
        resultsTable.enclosingScrollView?.drawsBackground = false
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField, self.paletteTextField.identifier == textField.identifier {
            mdqSearch?.updateQuery(to: textField.stringValue)
        }
        
        
    }
    
    @IBAction func onDisableClick(_ sender: Any) {
        mdqSearch = nil
    }
    
    
    @IBAction func onEnableClick(_ sender: Any) {
        mdqSearch = MDQSearch(onResultsUpdate: self.resultsUpdateHandler)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func resultsUpdateHandler(_ newResults: [LocalFileSearchResult]) {
        fileSearchResults = newResults.map({ result in
            result.displayName ?? ""
        })
        
        resultsTable?.reloadData()
    }
}

