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
`Collection needs to be an array of `String`s`. `TagCharacter` can be set when `collection` 
is set with `setup(collection: [String], withTagCharacter: String)` method.

```swift
guard let parentView = userInputTextField.superview else { return }

// In init you can also pass collection with default tagCharacter "@" or not
uitfCompletionHandler = UITFCompletionHandler.init(with: userInputTextField, withParentView: parentView)

// TagCharacter is passed (it can be any character) - default is "@"
uitfCompletionHandler.setup(collection: data, withTagCharacter: "#")

```

## Author

Matija Kruljac, kruljac.matija@gmail.com

## License

UITFCompletion is available under the MIT license. See the LICENSE file for more info.
