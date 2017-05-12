# UITFCompletion

UITFCompletion makes it easy to complete words or make tags of participants of group conversation in UITextField.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Xcode 8

## Installation

UITFCompletion is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

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
private var data = ["shark", "lion", "giraffe", "elephant", "orangutan"]
private var tagCharacter = "@" // or "##"

guard let parentView = userInputTextField.superview else { return }

// required parameters for initialization are UITextField for input and its parent view
// in init collection can be passed or not - if passed tagCharacter is "@" as default
uitfCompletionHandler = UITFCompletionHandler.init(with: userInputTextField, withParentView: parentView)

// setup collection and tagCharacter
// if setup(tagCharacter: String) is not called, tagCharacter will be "@" as default
uitfCompletionHandler.setup(collection: data)
uitfCompletionHandler.setup(tagCharacter: tagCharacter)
```

## Author

Matija Kruljac, kruljac.matija@gmail.com

## License

UITFCompletion is available under the MIT license. See the LICENSE file for more info.
