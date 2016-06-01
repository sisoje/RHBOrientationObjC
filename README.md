# RHBOrientationObjC

[![CI Status](http://img.shields.io/travis/Lazar Otasevic/RHBOrientationObjC.svg?style=flat)](https://travis-ci.org/Lazar Otasevic/RHBOrientationObjC)
[![Version](https://img.shields.io/cocoapods/v/RHBOrientationObjC.svg?style=flat)](http://cocoapods.org/pods/RHBOrientationObjC)
[![License](https://img.shields.io/cocoapods/l/RHBOrientationObjC.svg?style=flat)](http://cocoapods.org/pods/RHBOrientationObjC)
[![Platform](https://img.shields.io/cocoapods/p/RHBOrientationObjC.svg?style=flat)](http://cocoapods.org/pods/RHBOrientationObjC)

RHBOrientation is an easy to use and customizable Objective-C library for estimating device orientation based on accelerometer data.

Orientation detection uses PROPERLY designed "orientation snapping" algorithm with customizable z-axis and orientation snapping treshold value.

## Usage
Initialize orientation detection (for example in viewDidLoad) in your view controller:

    self.orienter = [RHBOrienter new];
    self.orienter.delegate = self;

Obtain orientation anytime using:

	self.orienter.deviceOrientation
	
Optionally implement delegate method to get notifications whenever orientation changes.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

RHBOrientationObjC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RHBOrientationObjC"
```

## Author

Lazar Otasevic, redhotbits@gmail.com

![alt tag](https://pbs.twimg.com/profile_images/1017152638/rhbt1_400x400.png)

## License

RHBOrientationObjC is available under the MIT license. See the LICENSE file for more info.
