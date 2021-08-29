//
//  SceneViewController.swift
//  Palette
//
//  Created by Ashwin on 23/08/21.
//

import Cocoa

protocol SceneViewController: NSViewController {
    func queryDidUpdate(to newQueryString: String) -> Void
}
