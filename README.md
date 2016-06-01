![alt tag](https://raw.githubusercontent.com/sisoje/RHBOrientationObjC/master/Example/RHBOrientationObjC/Images.xcassets/logo.imageset/logo.png)

# RHBOrientationObjC

[![CI Status](http://img.shields.io/travis/Lazar Otasevic/RHBOrientationObjC.svg?style=flat)](https://travis-ci.org/Lazar Otasevic/RHBOrientationObjC)
[![Version](https://img.shields.io/cocoapods/v/RHBOrientationObjC.svg?style=flat)](http://cocoapods.org/pods/RHBOrientationObjC)
[![License](https://img.shields.io/cocoapods/l/RHBOrientationObjC.svg?style=flat)](http://cocoapods.org/pods/RHBOrientationObjC)
[![Platform](https://img.shields.io/cocoapods/p/RHBOrientationObjC.svg?style=flat)](http://cocoapods.org/pods/RHBOrientationObjC)

RHBOrientation is an easy to use and customizable Objective-C library for estimating device orientation based on accelerometer data.

RHBOrientation uses raw accelerometer data to detect current phone orientation, and it works even when device is in "Orientation Lock" mode.

Orientation detection uses PROPERLY designed "orientation snapping" algorithm with customizable z-axis and orientation snapping treshold value.

## Usage

Import RHBOrientationObjC header file:

```objc
    #import "RHBOrientation.h"
```

Initialize orientation detection (for example in viewDidLoad) in your view controller:

```objc
    self.orienter = [RHBOrienter new];
```

Obtain orientation anytime using:

```objc
	self.orienter.deviceOrientation
```

Optionally setup delegate and implement delegate method to get notifications whenever orientation changes.

```objc
    self.orienter.delegate = self;
```

Your class must comply to RHBOrienterDelegate protocol and implement method:

```objc
    - (void)didChangeDeviceOrientation:(RHBOrienter *)orienter oldOrientation:(UIDeviceOrientation)oldOrientation newOrientation:(UIDeviceOrientation)newOrientation;
```

## Example

Clone the repo, and open Example/RHBOrientationObjC.xcodeproj. Orientation detection does not work in Simulator, since simulator does not support accelerometer.

## Installation

RHBOrientationObjC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RHBOrientationObjC"
```

## Author

Lazar Otasevic, redhotbits@gmail.com

## License

RHBOrientationObjC is available under the MIT license. See the LICENSE file for more info.
