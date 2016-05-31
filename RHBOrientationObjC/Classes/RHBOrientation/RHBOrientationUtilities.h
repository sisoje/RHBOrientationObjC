//
//  RHBOrientationUtilities.h
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/31/16.
//
//

@import UIKit;
@import AVFoundation;


@interface RHBOrientationUtilities : NSObject

+ (CGFloat)rotationAngleWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
+ (AVCaptureVideoOrientation)videoOrientationWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;

@end
