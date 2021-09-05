//
//  GoogleDriveSearchViewController.swift
//  Palette
//
//  Created by Ashwin on 31/08/21.
//

import Cocoa
import Moya

class GoogleDriveSearchViewController: NSViewController {
    var googleDriveSearch: GoogleDriveSearch!
    var requests = [Cancellable]()
    var searchTask: DispatchWorkItem?
    @objc dynamic var results = [ResultItem]()
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleDriveSearch = GoogleDriveSearch()
        googleDriveSearch.googleDriveSearchDelegate = self
        
        tableView.backgroundColor = .clear
    }
    
}

extension GoogleDriveSearchViewController: SceneViewController {
    func focusNextItem() {
        print("focusNextItem", tableView.numberOfRows, tableView.selectedRow)
        if tableView.selectedRow < 0 {
            tableView.selectRowIndexes([0], byExtendingSelection: false)
        } else if(tableView.selectedRow < tableView.numberOfRows) {
            tableView.selectRowIndexes([tableView.selectedRow + 1], byExtendingSelection: false)
        }
    }
    
    func focusPreviousItem() {
        print("focusNextItem", tableView.numberOfRows, tableView.selectedRow)
        if(tableView.selectedRow > 0) {
            tableView.selectRowIndexes([tableView.selectedRow - 1], byExtendingSelection: false)
        }
    }
    
    func queryDidUpdate(to newQueryString: String) {
        guard newQueryString.count > 0 else {
            return
        }
        
        self.searchTask?.cancel()
        requests.forEach { cancellable in cancellable.cancel() }
        requests.removeAll()
        
        let task = DispatchWorkItem { [weak self] in
            let request = self?.googleDriveSearch.search(query: newQueryString)
            
            guard let request = request else { return }
            self?.requests.append(request)
            self?.tableView.selectRowIndexes([0], byExtendingSelection: false)
        }
        self.searchTask = task

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05, execute: task)
    }
}

extension GoogleDriveSearchViewController: GoogleDriveSearchDelegate {
    func googleDriveSearchResultsDidUpdate(_ newResults: [ResultItem]) {
        self.results = newResults
    }
}
