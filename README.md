# UITFCompletion

UITFCompletion makes it easy to complete words or make tags of participants of group conversation for instance in UITextField like Facebook Messenger.

[![Version](https://img.shields.io/cocoapods/v/UITFCompletion.svg?style=flat)](http://cocoapods.org/pods/UITFCompletion)
[![License](https://img.shields.io/cocoapods/l/UITFCompletion.svg?style=flat)](http://cocoapods.org/pods/UITFCompletion)
[![Platform](https://img.shields.io/cocoapods/p/UITFCompletion.svg?style=flat)](http://cocoapods.org/pods/UITFCompletion)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
This gif shows example application in which collection and tag character can be edited.  

</br>
<p>
<p align="center">
  <img src="https://github.com/MatijaKruljac/UITFCompletion/blob/master/uitf_example_video.gif?raw=true" >
</p>
</br>

## Requirements

- iOS 8.0+
- Xcode 8
- Swift 3.0

## Installation

UITFCompletion is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following lines to your Podfile:

```swift
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
    pod "UITFCompletion"
end
```

## Usage

Using `UITFCompletion` is very easy. Just call `init` method and pass all required parameters.
Collection must be an array of `String`s.` TagCharacter `can be set when `collection` 
is set with `setup(collection: collection, withTagCharacter: String)` method.

```swift
// initial setup for example
private var data = ["shark", "lion", "giraffe", "elephant", "orangutan", "dog", "cat"]
private var tagCharacter = "@" // or "##"

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
```

## Author

Matija Kruljac, kruljac.matija@gmail.com

## License

UITFCompletion is available under the MIT license. See the LICENSE file for more info.
