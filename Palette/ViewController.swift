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
    var localFileSearch: LocalFileSearch!
    @objc dynamic var fileSearchResults = [String]()
    
    @IBOutlet var fileResultsArrayController: NSArrayController!
    @IBOutlet weak var paletteTextField: NSTextField!
    @IBOutlet weak var resultsTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paletteTextField.delegate = self
        localFileSearch = LocalFileSearch(onResultsUpdate: self.resultsUpdateHandler)
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField, self.paletteTextField.identifier == textField.identifier {
            localFileSearch.updateQueryString(to: textField.stringValue)
        }
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

