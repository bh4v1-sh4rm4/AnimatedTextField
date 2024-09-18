# AnimatedTextField

[![Version](https://img.shields.io/cocoapods/v/AnimatedTextField.svg?style=flat)](https://cocoapods.org/pods/AnimatedTextField)
[![License](https://img.shields.io/cocoapods/l/AnimatedTextField.svg?style=flat)](https://cocoapods.org/pods/AnimatedTextField)
[![Platform](https://img.shields.io/cocoapods/p/AnimatedTextField.svg?style=flat)](https://cocoapods.org/pods/AnimatedTextField)
[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://developer.apple.com/swift/)

AnimatedTextField is a reusable, customizable text field with animated placeholder support. It enhances the user experience by animating the placeholder when the user interacts with the text field, making it ideal for forms and input fields.

## Features

- [x] **Placeholder Animation:** Placeholder animates when the text field gains focus.
- [x] **Customizable:** Easily customizable via Interface Builder (XIB) or programmatically.
- [x] **Reusable Component:** Plug and play in any project with minimal setup.
- [x] **Swift and XIB-based:** Fully written in Swift with XIB for UI customization.
- [x] **Supports Interface Builder:** See live updates while designing in Interface Builder.

## Preview

![AnimatedTextField Preview](https://yourimageurl.com/animatedtextfield-demo.gif)

## Installation

### CocoaPods

To integrate `AnimatedTextField` into your Xcode project using [CocoaPods](https://cocoapods.org), specify it in your `Podfile`:

```ruby
pod 'AnimatedTextField', '~> 1.0.0'
```

Then, run the following command:
```ruby
pod install
```
## Usage

1. Import AnimatedTextField into your view controller.

```ruby
import AnimatedTextField
```
2. Drag and drop a UIView into your storyboard and set its class to AnimatedTextField.
  
3. Connect the AnimatedTextField to your view controller and customize its properties directly from the Attributes Inspector or programmatically.

4. Give the textfield delegate in the view/viewcontorller lifecycle method.

### Example
```ruby
let textField = AnimatedTextField()
textField.delegate = self
textField.placeholder = "Enter your name"
// Additional customization
```

## Customization

You can further customize the look and behavior of `AnimatedTextField` by editing the XIB file or programmatically.

```ruby
textField.placeholderColor = .gray
textField.textColor = .black
textField.placeholderAnimationDuration = 0.3
```

## Requirements

. iOS 11.0+ 

.Swift 5.0+

## Contribution

Feel free to contributing for new customizations or feature enhancements or opening issues. I'll try my best to keep it updated.

## Contact

For any queries or issues, please reach out at [this email address](bhavishya.0709@gmail.com).

