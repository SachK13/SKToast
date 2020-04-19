# SKToast

[![Version](https://img.shields.io/cocoapods/v/SKToast.svg?style=flat)](http://cocoapods.org/pods/SKToast)
[![License](https://img.shields.io/cocoapods/l/SKToast.svg?style=flat)](http://cocoapods.org/pods/SKToast)
[![Platform](https://img.shields.io/cocoapods/p/SKToast.svg?style=flat)](http://cocoapods.org/pods/SKToast)

![SKToast](SKToastView.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

- [x] ToastView Customization
- [x] Easy & Quick Integration


## Requirements

- iOS 13.0+
- Xcode 11+
- Swift 5.0+

## Installation

### CocoaPods
To integrate SKToast into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

target '<Your Target Name>' do
pod 'SKToast', '~> 1.0.0'
end
```

Then, run the following command:

```swift
$ pod install
```


### Manual
You can directly add the `SKToastView.swift` source files into your Xcode project.

Include SKToastView wherever you need it with `import SKToast`.


## Usage

(see sample Xcode project in `/Example`)
To run the example project, clone the repo, and run `pod install` from the Example directory first.

Import the module.
```swift
import SKToast
```


Now, you can show ToastView with status message:
```swift
SKToast.show(withMessage: "Please check your intenet connection.")
```


Display ToastView with status message and completionHandler:
```swift
SKToast.show(withMessage: "Your internet connection appears to be offline, please check your internet connection") {
         print("Perform any task after toast disappearance.")
}
```


## Customization
```swift
// default is dark
SKToast.backgroundStyle(.light)


// default is white
SKToast.messageTextColor(UIColor.black)


// default is System Font
let myFont = UIFont(name: "AvenirNext-DemiBold", size: 16)
SKToast.messageFont(myFont!)


// ToastView background styles
SKToast.backgroundStyle(.light)
SKToast.backgroundStyle(.extraLight)
SKToast.backgroundStyle(.dark)
```

## License

SKToast is available under the MIT license. [See LICENSE](https://github.com/SachK13/SKToast/blob/master/LICENSE) for details.
