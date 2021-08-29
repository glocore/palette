//
//  WidgetsViewController.swift
//  Palette
//
//  Created by Ashwin on 28/08/21.
//

import Cocoa

class WidgetsViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension WidgetsViewController: SceneViewController {
    func queryDidUpdate(to newQueryString: String) {}
}
