//
//  RHBOrientationUtilities.h
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/31/16.
//
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


@interface RHBOrientationUtilities : NSObject

+ (instancetype)sharedInstance;

- (CGFloat)rotationAngleWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
- (AVCaptureVideoOrientation)videoOrientationWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
- (CGAffineTransform)transformationWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation;

@end
