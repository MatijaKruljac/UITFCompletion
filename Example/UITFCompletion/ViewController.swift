//
//  ViewController.swift
//  UITFCompletion
//
//  Created by Matija Kruljac on 05/11/2017.
//  Copyright (c) 2017 Matija Kruljac. All rights reserved.
//

import UIKit
import UITFCompletion

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var tagsTextView: UITextView!
    @IBOutlet weak var tagCharacterTextField: UITextField!
    
    private var uitfCompletionHandler: UITFCompletionHandler!
    
    // initial setup for example
    private var data = ["shark", "lion", "giraffe", "elephant", "orangutan"]
    private var tagCharacter = "@"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITFCompletion Example"
    
        setupTextUIElementes()
        setupBackgroundColors()
        setupUITFCompletionHandler()
        displayTags()
    }
    
    private func setupTextUIElementes() {
        tagsTextView.delegate = self
        tagCharacterTextField.delegate = self
        tagCharacterTextField.text = tagCharacter
    }
    
    private func setupBackgroundColors() {
        view.backgroundColor = UIColor(red: 1, green: 0.9098, blue: 0.9098, alpha: 1.0)
        tagsTextView.backgroundColor = .white
    }
    
    private func setupUITFCompletionHandler() {
        guard let parentView = userInputTextField.superview else { return }
        
        // required parameters for initialization are UITextField for input and its parent view
        // in init collection can be passed or not - if passed tagCharacter is "@" as default
        uitfCompletionHandler = UITFCompletionHandler.init(with: userInputTextField, withParentView: parentView)
        
        // setup collection and tagCharacter
        // if setup(tagCharacter: String) is not called, tagCharacter will be "@" as default
        uitfCompletionHandler.setup(collection: data)
        uitfCompletionHandler.setup(tagCharacter: tagCharacter)
        
        // colors for completion holder text and chosen tag can be changed - default color is .blue
        uitfCompletionHandler.changeCompletionText(color: UIColor(red: 0, green: 0.6275, blue: 0.2275, alpha: 1.0))
        uitfCompletionHandler.changeChosenTag(color: UIColor(red: 0.8863, green: 0, blue: 0.0588, alpha: 1.0))
    }
    
    private func displayTags() {
        let mutableString = NSMutableString()
        for index in 0...data.count-1 {
            if index < data.count-1 {
                mutableString.append(data[index] + ", ")
            } else {
                mutableString.append(data[index])
            }
        }
        tagsTextView.text = mutableString as String
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateCollection()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateCollection()
    }
    
    private func updateCollection() {
        data.removeAll()
        data = tagsTextView.text.components(separatedBy: ",").map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        if let tagCharacter = tagCharacterTextField.text {
            self.tagCharacter = tagCharacter
        }
        
        // update collection and tagCharacter
        uitfCompletionHandler.setup(collection: data)
        uitfCompletionHandler.setup(tagCharacter: tagCharacter)
    }
}

