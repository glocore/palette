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
    
    private var sceneViewController: NSViewController?
    private var sceneName: SceneName!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainTextFieldStyling()
        commandTextField.delegate = self
        replaceCurrentScene(with: .rootSearch)
    }
    
    private func setMainTextFieldStyling() {
        commandTextField.backgroundColor = .clear
        commandTextField.isBezeled = false
        commandTextField.drawsBackground = false
        commandTextField.layer?.cornerRadius = 10
    }
}

extension MainViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        print(commandTextField.stringValue)
    }
}

enum SceneName {
    case rootSearch
}

extension MainViewController {
    
    private func replaceCurrentScene(with newSceneName: SceneName) {
        sceneViewController?.view.removeFromSuperview()
        
        switch newSceneName {
        case .rootSearch:
            sceneName = .rootSearch
            sceneViewController = RootSearchViewController.init(nibName: "RootSearchViewController", bundle: nil)
            break
        }
        
        sceneView.addSubview(sceneViewController!.view)
    }
}
