//
//  RHBOrientationUtilities.m
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/31/16.
//
//

#import "RHBOrientationUtilities.h"


@interface RHBOrientationUtilities ()

@property (nonatomic, readonly) NSDictionary *rotationAngleByDeviceOrientation;
@property (nonatomic, readonly) NSDictionary *videoOrientationByDeviceOrientation;

@end


@implementation RHBOrientationUtilities

- (instancetype)init {
    
    if (self = [super init]) {
        
        _rotationAngleByDeviceOrientation =
        @{@(UIDeviceOrientationPortrait) : @(0),
          @(UIDeviceOrientationLandscapeLeft) : @(M_PI_2),
          @(UIDeviceOrientationLandscapeRight) : @(-M_PI_2),
          @(UIDeviceOrientationPortraitUpsideDown) : @(M_PI)};
        
        _videoOrientationByDeviceOrientation =
        @{@(UIDeviceOrientationPortrait) : @(AVCaptureVideoOrientationPortrait),
          @(UIDeviceOrientationLandscapeLeft) : @(AVCaptureVideoOrientationLandscapeRight),
          @(UIDeviceOrientationLandscapeRight) : @(AVCaptureVideoOrientationLandscapeLeft),
          @(UIDeviceOrientationPortraitUpsideDown) : @(AVCaptureVideoOrientationPortraitUpsideDown)};
    }
    
    return self;
}

+ (instancetype)instance {
    
    static id instance = nil;
    if (!instance) {
        
        instance = [self new];
    }
    
    return instance;
}

+ (CGFloat)rotationAngleWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    
    NSNumber *rotationAngle = [RHBOrientationUtilities instance].rotationAngleByDeviceOrientation[@(deviceOrientation)];
    NSAssert(rotationAngle, @"has to be maped");
    
    return rotationAngle.floatValue;
}

+ (AVCaptureVideoOrientation)videoOrientationWithDeviceOrientation:(UIDeviceOrientation)deviceOrientation {
    
    NSNumber *videoOrientation = [RHBOrientationUtilities instance].videoOrientationByDeviceOrientation[@(deviceOrientation)];
    NSAssert(videoOrientation, @"has to be maped");
    
    return videoOrientation.integerValue;
}

@end
