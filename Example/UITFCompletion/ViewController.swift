//
//  ViewController.swift
//  UITFCompletion
//
//  Created by Matija Kruljac on 05/11/2017.
//  Copyright (c) 2017 Matija Kruljac. All rights reserved.
//

import UIKit
import UITFCompletion

class ViewController: UIViewController {

    @IBOutlet weak var userInputTextField: UITextField!
    
    private var uitfCompletionHandler: UITFCompletionHandler!
    
    private var data = ["shark", "lion", "giraffe", "elephant", "orangutan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITFCompletion Example"
        setupBackgroundColor()
        setupUITFCompletionHandler()
    }
    
    private func setupBackgroundColor() {
        view.backgroundColor = UIColor(red: 1, green: 0.9098, blue: 0.9098, alpha: 1.0)
    }
    
    private func setupUITFCompletionHandler() {
        guard let parentView = userInputTextField.superview else { return }
        uitfCompletionHandler = UITFCompletionHandler.init(with: userInputTextField, withParentView: parentView, andWithCollection: data)
    }
}

