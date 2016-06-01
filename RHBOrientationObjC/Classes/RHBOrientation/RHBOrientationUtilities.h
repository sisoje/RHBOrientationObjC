//
//  RHBOrientationUtilities.h
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/31/16.
//
//

@import UIKit;
@import AVFoundation;

#import "RHBSnippets.h"


@interface RHBOrientationUtilities : NSObject

RHB_SINGLETON_INTERFACE();

- (CGFloat)rotationAngleWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
- (AVCaptureVideoOrientation)videoOrientationWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
- (CGAffineTransform)transformationWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;

@end
