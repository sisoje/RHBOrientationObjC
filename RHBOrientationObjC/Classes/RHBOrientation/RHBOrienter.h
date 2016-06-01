//
//  RHBOrienter.h
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/28/16.
//
//

@import UIKit;

@class RHBOrienter;


@protocol RHBOrienterDelegate <NSObject>

- (void)didChangeDeviceOrientation:(RHBOrienter *)orienter oldOrientation:(UIDeviceOrientation)oldOrientation newOrientation:(UIDeviceOrientation)newOrientation;

@end


@interface RHBOrienter : NSObject

/** Params:
    initialOrientation used only because accelerometer has delay in reporting accelerometer data
    zAxisThreshold from 0 to 1
    snappingAngle from 0 to 22.5
*/
- (instancetype)initWithInitialOrientation:(UIDeviceOrientation)initialOrientation zAxisThreshold:(double)zAxisThreshold snappingAngle:(double)snappingAngle;

/** Default init uses:
    initialOrientation = UIDeviceOrientationPortrait
    zAxisThreshold = 0.85
    snappingAngle = 12
 */
- (instancetype)init;


/// Current estimated device orientation
@property (nonatomic, readonly) UIDeviceOrientation deviceOrientation;

/// Optional delegate
@property (nonatomic, weak) id<RHBOrienterDelegate> delegate;

@end
