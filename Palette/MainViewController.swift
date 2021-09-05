//
//  MainViewController.swift
//  Palette
//
//  Created by Ashwin on 22/08/21.
//

import Cocoa

class MainViewController: NSViewController {
    @IBOutlet weak var sceneView: NSView!
    @IBOutlet weak var commandTextField: NSTextField!
    
    private var sceneViewController: SceneViewController?
    private var sceneName: SceneName!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainTextFieldStyling()
        commandTextField.delegate = self
        replaceCurrentScene(with: .widgets)
    }
    
    private func setMainTextFieldStyling() {
        commandTextField.backgroundColor = .clear
        commandTextField.isBezeled = false
        commandTextField.drawsBackground = false
        commandTextField.layer?.cornerRadius = 10
    }
}

extension MainViewController: NSTextFieldDelegate, NSControlTextEditingDelegate {
    func controlTextDidChange(_ obj: Notification) {
        if(commandTextField.stringValue.count == 0) {
            replaceCurrentScene(with: .widgets)
            return
        }
        
        /// TODO: scene view selection logic
        if(sceneName != .googleDriveSearch) {
            replaceCurrentScene(with: .googleDriveSearch)
        }
        
        let sanitisedQuery = QuerySanitiser().sanitise(commandTextField.stringValue)
        
        sceneViewController?.queryDidUpdate(to: sanitisedQuery)
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(moveUp) {
            sceneViewController?.focusPreviousItem()
            print("up")
            return true
        } else if commandSelector == #selector(moveDown) {
            sceneViewController?.focusNextItem()
            print("down")
            return true
        } else if commandSelector == #selector(insertNewline) {
            return true
        }
        return false
    }
}

enum SceneName {
    case widgets
    case rootSearch
    case googleDriveSearch
}

extension MainViewController {
    
    private func replaceCurrentScene(with newSceneName: SceneName) {
        sceneViewController?.view.removeFromSuperview()
        
        switch newSceneName {
        case .widgets:
            sceneName = .widgets
            sceneViewController = WidgetsViewController(nibName: "WidgetsViewController", bundle: nil)
            break
        case .rootSearch:
            sceneName = .rootSearch
            sceneViewController = RootSearchViewController(nibName: "RootSearchViewController", bundle: nil)
            break
        case .googleDriveSearch:
            sceneName = .googleDriveSearch
            sceneViewController = GoogleDriveSearchViewController(nibName: "GoogleDriveSearchViewController", bundle: nil)
            break
        }
        
        
        sceneView.addSubview(sceneViewController!.view)
        let sceneSize = sceneView.frame
        sceneViewController!.view.frame = CGRect(x: 0, y: 0, width: sceneSize.width, height: sceneSize.height)
    }
}
