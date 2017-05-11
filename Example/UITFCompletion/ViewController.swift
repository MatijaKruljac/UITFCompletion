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
    @IBOutlet weak var tagsTextView: UITextView!
    
    private var uitfCompletionHandler: UITFCompletionHandler!
    
    private var data = ["shark", "lion", "giraffe", "elephant", "orangutan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITFCompletion Example"
        setupBackgroundColor()
        setupUITFCompletionHandler()
        displayTags()
    }
    
    private func setupBackgroundColor() {
        view.backgroundColor = UIColor(red: 1, green: 0.9098, blue: 0.9098, alpha: 1.0)
    }
    
    private func setupUITFCompletionHandler() {
        guard let parentView = userInputTextField.superview else { return }
        
        // In init you can also pass collection with default tagCharacter "@" or not
        uitfCompletionHandler = UITFCompletionHandler.init(with: userInputTextField, withParentView: parentView)
        
        // TagCharacter is passed (it can be any character) - default is "@"
        uitfCompletionHandler.setup(collection: data, withTagCharacter: "#")
    }
    
    private func displayTags() {
        let mutableString = NSMutableString()
        mutableString.append("TAGS: ")
        for index in 0...data.count-1 {
            if index < data.count-1 {
                mutableString.append(data[index] + ", ")
            } else {
                mutableString.append(data[index])
            }
        }
        tagsTextView.text = mutableString as String
    }
}

