//
//  RootSearchViewController.swift
//  Palette
//
//  Created by Ashwin on 22/08/21.
//

import Cocoa

class RootSearchViewController: NSViewController {
    
    let localAppSearch = LocalAppSearch()
    @objc dynamic var results = [ResultItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localAppSearch.localAppSearchDelegate = self
    }
}

extension RootSearchViewController: SceneViewController {
    func focusNextItem() {}
    
    func focusPreviousItem() {}
    
    
    func queryDidUpdate(to newQueryString: String) {
        localAppSearch.updateQuery(to: newQueryString)
    }
}

extension RootSearchViewController: LocalAppSearchDelegate {
    
    func localAppResultsDidUpdate(_ newResults: [ResultItem]) {
        results = newResults
    }
}
