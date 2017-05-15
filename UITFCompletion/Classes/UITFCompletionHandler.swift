//
//  UITFCompletionHandler.swift
//  UITFCompletion
//
//  Created by Matija Kruljac on 5/8/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

public class UITFCompletionHandler: NSObject, UITextFieldDelegate {
    
    private var completionTextHolder: UILabel!
    private var userTextField: UITextField!
    
    private var completionTextColor: UIColor!
    private var chosenTagColor: UIColor!
    
    private var collection = [String]()
    private var chosenTags = [String]()
    private var tagCharacter = String()
    private var containedAttributedText = NSMutableAttributedString()
    
    public init(with userTextField: UITextField, withParentView parentView: UIView, andWithCollection collection: [String]? = nil) {
        super.init()
        
        setup(userTextField: userTextField)
        setupCompletionTextHolder(withParentView: parentView)
        
        if self.tagCharacter.isEmpty {
            setup(tagCharacter: Tags.defaultCharacter.value)
        }
        if let collection = collection {
            setup(collection: collection)
        }
        
        changeCompletionText(color: .blue)
        changeChosenTag(color: .blue)
    }
    
    public func setup(collection: [String]) {
        if self.collection.count > 0 {
            self.collection.removeAll()
        }
        _ = collection.map {
            self.collection.append($0)
        }
    }
    
    public func setup(tagCharacter: String) {
        self.tagCharacter = tagCharacter
    }
    
    public func changeCompletionText(color: UIColor) {
        completionTextHolder.textColor = color
    }
    
    public func changeChosenTag(color: UIColor) {
        chosenTagColor = color
    }
    
    private func setup(userTextField: UITextField) {
        self.userTextField = userTextField
        self.userTextField.delegate = self
    }
    
    private func setupCompletionTextHolder(withParentView parentView: UIView) {
        completionTextHolder = UILabel()
        completionTextHolder.isUserInteractionEnabled = true
        let rect = CGRect(
            x: userTextField.frame.origin.x,
            y: userTextField.frame.origin.y,
            width: userTextField.frame.size.width,
            height: userTextField.frame.size.height)
        completionTextHolder.frame = rect
        addTapGestureRecgnizerOnCompletionTextHolder()
        parentView.insertSubview(completionTextHolder, belowSubview: userTextField)
    }
    
    private func addTapGestureRecgnizerOnCompletionTextHolder() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        completionTextHolder.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        translateCompletionTextHolderDown(with: { [weak self] _ in
            guard
                let completionTextHolderText = self?.completionTextHolder.text
            else { return }
            
            self?.appendSuggestion(forCompletion: completionTextHolderText)
            self?.completionTextHolder.text = ""
        })
    }
    
    private func appendSuggestion(forCompletion completionTextHolderText: String) {
        if let userTextFieldText = userTextField.text,
            userTextFieldText.components(separatedBy: " ").count > 1 {
            let emptySpace = createAttributed(string: " ", with: .black)
            containedAttributedText.append(emptySpace)
        }
        
        let chosenSuggestion = createAttributed(string: completionTextHolderText, with: chosenTagColor)
        containedAttributedText.append(chosenSuggestion)
        userTextField.attributedText = containedAttributedText
        
        chosenTags.append(completionTextHolderText)
    }
    
    private func createAttributed(string: String, with color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string, attributes: [:])
        attributedString.addAttribute(NSForegroundColorAttributeName,
                                   value: color,
                                   range: NSRange(location: 0, length: string.characters.count))
        return attributedString
    }
    
    private func setSugestionAndAnimate(with text: String) {
        guard let lastWord = text.components(separatedBy: " ").last else { return }
        var contains = false
        _ = collection.map {
            if $0.contains(lastWord) {
                contains = true
                completionTextHolder.text = tagCharacter + $0
                translateCompletionTextHolderUp()
            }
        }
        if !contains {
            translateCompletionTextHolderDown(with: nil)
        }
    }
    
    private func translateCompletionTextHolderUp() {
        if Int(completionTextHolder.frame.origin.y) == Int(userTextField.frame.origin.y) {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0, options: [], animations: { [weak self] _ in
                            guard var frame = self?.completionTextHolder.frame else { return }
                            frame.origin.y -= frame.size.height
                            self?.completionTextHolder.frame = frame
                }, completion: nil)
        }
    }
    
    private func translateCompletionTextHolderDown(with completion: ((Bool)->())? = nil) {
        if Int(completionTextHolder.frame.origin.y) < Int(userTextField.frame.origin.y) {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0, options: [], animations: { [weak self] _ in
                            guard var frame = self?.completionTextHolder.frame else { return }
                            frame.origin.y += frame.size.height
                            self?.completionTextHolder.frame = frame
                }, completion: completion)
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.typingAttributes = [NSForegroundColorAttributeName : UIColor.black]
        
        if (range.length == 1 && string.isEmpty) {
            handleBackspaceTap()
        } else {
            guard let userInputText = textField.text else { return true }
            setSugestionAndAnimate(with: userInputText)
            handleIfTappedSpace(string: string)
        }
        return true
    }
    
    private func handleBackspaceTap() {
        guard
            let userTextFieldText = userTextField.text
        else { return }
    
        for index in stride(from: 0, through: chosenTags.count-1, by: 1) {
            if userTextFieldText.hasSuffix(chosenTags[index]) {
                updateContainedAttributedText()
                containedAttributedText.replaceCharacters(in: NSMakeRange(containedAttributedText.string.characters.count - chosenTags[index].characters.count,
                                                                          chosenTags[index].characters.count), with: "")
                userTextField.attributedText = containedAttributedText
                
                if let index = chosenTags.index(of: chosenTags[index]) {
                    chosenTags.remove(at: index)
                }
                break;
            }
        }
        translateCompletionTextHolderDown(with: nil)
    }
    
    private func handleIfTappedSpace(string: String) {
        let whitespaceSet = NSCharacterSet.whitespaces
        if let _ = string.rangeOfCharacter(from: whitespaceSet) {
            updateContainedAttributedText()
        }
    }
    
    private func updateContainedAttributedText() {
        if let userTextFieldAttributedText = userTextField.attributedText,
            let attributedTextMutableCopy = userTextFieldAttributedText.mutableCopy() as? NSMutableAttributedString  {
            containedAttributedText = attributedTextMutableCopy
        }
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        containedAttributedText = NSMutableAttributedString()
        chosenTags.removeAll()
        return true
    }
}

enum Tags: String {
    case defaultCharacter
    
    var value: String {
        switch self {
        case .defaultCharacter:
            return "@"
        }
    }
}
