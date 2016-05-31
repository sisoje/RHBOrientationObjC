//
//  RHBOrienter.m
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/28/16.
//
//

#import "RHBOrienter.h"
#import <CoreMotion/CoreMotion.h>


#define isPortrait(angle, histerezis) (angle >= -3*M_PI_4-histerezis && angle <= -M_PI_4+histerezis)
#define isRight(angle, histerezis) (angle <= -3*M_PI_4+histerezis || angle >= 3*M_PI_4-histerezis)
#define isLeft(angle, histerezis) (angle <= M_PI_4+histerezis && angle >= -M_PI_4-histerezis)
#define isUpsideDown(angle, histerezis) (angle >= M_PI_4-histerezis && angle <= 3*M_PI_4+histerezis)


@interface RHBOrienter ()

@property (nonatomic, readonly) CMMotionManager *motionManager;
@property (nonatomic, readonly) NSOperationQueue *motionQueue;
@property (nonatomic) UIDeviceOrientation lastKnownOrientation;
@property (nonatomic, readonly) double zTrashold;
@property (nonatomic, readonly) double angleTrashold;

@end


@implementation RHBOrienter

- (instancetype)initWithInitialOrientation:(UIDeviceOrientation)initialOrientation zTrashold:(double)zTrashold angleTrashold:(double)angleTrashold {
    
    if (self = [super init]) {
        
        _zTrashold = zTrashold;
        _angleTrashold = angleTrashold*(M_PI/180);
        _deviceOrientation = initialOrientation;
        _lastKnownOrientation = UIDeviceOrientationUnknown;
        
        _motionQueue = [NSOperationQueue new];
        _motionQueue.maxConcurrentOperationCount = 1;
        
        _motionManager = [[CMMotionManager alloc] init];
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
    
    return [self initWithInitialOrientation:UIDeviceOrientationPortrait zTrashold:0.85 angleTrashold:12];
}

+ (UIDeviceOrientation)deviceOrientationWithAngle:(double)angle {
    
    NSAssert(angle+0.001 >= -M_PI && angle-0.001 <= M_PI, @"valid angle");
    
    if (isPortrait(angle, 0)) {
        
        return UIDeviceOrientationPortrait;
    }
    
    if (isRight(angle, 0)) {
        
        return UIDeviceOrientationLandscapeRight;
    }
    
    if (isLeft(angle, 0)) {
        
        return UIDeviceOrientationLandscapeLeft;
    }
    
    NSAssert(isUpsideDown(angle, 0), @"upside down");
    return UIDeviceOrientationPortraitUpsideDown;
}

- (UIDeviceOrientation)calculateOrientation:(double)angle {
    
    if (self.lastKnownOrientation == UIDeviceOrientationPortrait && isPortrait(angle, self.angleTrashold)) {
        
        return UIDeviceOrientationPortrait;
    }
    
    if (self.lastKnownOrientation == UIDeviceOrientationLandscapeRight && isRight(angle, self.angleTrashold)) {
        
        return UIDeviceOrientationLandscapeRight;
    }
    
    if (self.lastKnownOrientation == UIDeviceOrientationLandscapeLeft && isLeft(angle, self.angleTrashold)) {
        
        return UIDeviceOrientationLandscapeLeft;
    }
    
    if (self.lastKnownOrientation == UIDeviceOrientationPortraitUpsideDown && isUpsideDown(angle, self.angleTrashold)) {
        
        return UIDeviceOrientationPortraitUpsideDown;
    }
    
    return [[self class] deviceOrientationWithAngle:angle];
}

- (void)processData:(CMAccelerometerData *)accelerometerData {
    
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    if (fabs(acceleration.z) >= self.zTrashold) {
        
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
    
    if (self.delegate) {
        
        __weak RHBOrienter *weakSelf = self;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [weakSelf.delegate didChangeDeviceOrientation:weakSelf oldOrientation:oldOrientation newOrientation:newOrientation];
        }];
    }
    
    _deviceOrientation = newOrientation;
}

- (void)dealloc {
    
    [self.motionManager stopAccelerometerUpdates];
}

@end
