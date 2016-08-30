//
//  RHBOrienter.m
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/28/16.
//
//

#import "RHBOrienter.h"
#import <CoreMotion/CoreMotion.h>


#define isPortrait(ANGLE, SNAPPING_ANGLE) (ANGLE >= -3*M_PI_4-SNAPPING_ANGLE && ANGLE <= -M_PI_4+SNAPPING_ANGLE)
#define isRight(ANGLE, SNAPPING_ANGLE) (ANGLE <= -3*M_PI_4+SNAPPING_ANGLE || ANGLE >= 3*M_PI_4-SNAPPING_ANGLE)
#define isLeft(ANGLE, SNAPPING_ANGLE) (ANGLE <= M_PI_4+SNAPPING_ANGLE && ANGLE >= -M_PI_4-SNAPPING_ANGLE)
#define isUpsideDown(ANGLE, SNAPPING_ANGLE) (ANGLE >= M_PI_4-SNAPPING_ANGLE && ANGLE <= 3*M_PI_4+SNAPPING_ANGLE)


@interface RHBOrienter ()

@property (nonatomic, readonly) CMMotionManager *motionManager;
@property (nonatomic, readonly) NSOperationQueue *motionQueue;
@property (nonatomic) UIDeviceOrientation lastKnownOrientation;
@property (nonatomic, readonly) double zAxisThreshold;
@property (nonatomic, readonly) double snappingAngle;

@end


@implementation RHBOrienter

- (instancetype)initWithInitialOrientation:(UIDeviceOrientation)initialOrientation zAxisThreshold:(double)zAxisThreshold snappingAngle:(double)snappingAngle {
    
    NSAssert(([@[@(UIDeviceOrientationPortrait), @(UIDeviceOrientationLandscapeRight), @(UIDeviceOrientationLandscapeLeft), @(UIDeviceOrientationPortraitUpsideDown)] containsObject:@(initialOrientation)]), @"has to be valid orientation");
             
    if (self = [super init]) {
        
        _zAxisThreshold = zAxisThreshold;
        _snappingAngle = snappingAngle*(M_PI/180);
        _deviceOrientation = initialOrientation;
        _lastKnownOrientation = UIDeviceOrientationUnknown;
        
        _motionQueue = [NSOperationQueue new];
        _motionQueue.maxConcurrentOperationCount = 1;
        
        _motionManager = [CMMotionManager new];
        __weak typeof(self) weakSelf = self;
        [_motionManager startAccelerometerUpdatesToQueue:_motionQueue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            
            if (error) {
                
                NSLog(@"motion error %@", error);
                return;
            }
            
            if (accelerometerData) {
                
                [weakSelf processData:accelerometerData];
            }
        }];
    }
    
    return self;
}

- (instancetype)init {
    
    return self = [self initWithInitialOrientation:UIDeviceOrientationPortrait zAxisThreshold:0.85 snappingAngle:12];
}

+ (UIDeviceOrientation)deviceOrientationWithAngle:(double)angle {
    
    NSAssert(angle+0.001 >= -M_PI && angle-0.001 <= M_PI, @"valid angle from atan2");
    
    if (isPortrait(angle, 0)) {
        
        return UIDeviceOrientationPortrait;
    }
    
    if (isRight(angle, 0)) {
        
        return UIDeviceOrientationLandscapeRight;
    }
    
    if (isLeft(angle, 0)) {
        
        return UIDeviceOrientationLandscapeLeft;
    }
    
    NSAssert(isUpsideDown(angle, 0), @"no other than upside down");
    return UIDeviceOrientationPortraitUpsideDown;
}

- (UIDeviceOrientation)calculateOrientation:(double)angle {
    
    if (self.lastKnownOrientation == UIDeviceOrientationPortrait && isPortrait(angle, self.snappingAngle)) {
        
        return UIDeviceOrientationPortrait;
    }
    
    if (self.lastKnownOrientation == UIDeviceOrientationLandscapeRight && isRight(angle, self.snappingAngle)) {
        
        return UIDeviceOrientationLandscapeRight;
    }
    
    if (self.lastKnownOrientation == UIDeviceOrientationLandscapeLeft && isLeft(angle, self.snappingAngle)) {
        
        return UIDeviceOrientationLandscapeLeft;
    }
    
    if (self.lastKnownOrientation == UIDeviceOrientationPortraitUpsideDown && isUpsideDown(angle, self.snappingAngle)) {
        
        return UIDeviceOrientationPortraitUpsideDown;
    }
    
    return [[self class] deviceOrientationWithAngle:angle];
}

- (void)processData:(CMAccelerometerData *)accelerometerData {
    
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    if (fabs(acceleration.z) >= self.zAxisThreshold) {
        
        self.lastKnownOrientation = UIDeviceOrientationUnknown;
        return;
    }
    
    UIDeviceOrientation newOrientation = [self calculateOrientation:atan2(acceleration.y, -acceleration.x)];
    if (newOrientation == self.lastKnownOrientation) {
        
        return;
    }
    
    self.lastKnownOrientation = newOrientation;
    
    UIDeviceOrientation oldOrientation = self.deviceOrientation;
    if (newOrientation == oldOrientation) {
        
        return;
    }
    
    _deviceOrientation = newOrientation;
    
    if (!self.delegate) {
        
        return;
    }
    
    __weak RHBOrienter *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [weakSelf.delegate didChangeDeviceOrientation:weakSelf oldOrientation:oldOrientation newOrientation:newOrientation];
    }];
}

- (void)dealloc {
    
    [self.motionManager stopAccelerometerUpdates];
}

@end
