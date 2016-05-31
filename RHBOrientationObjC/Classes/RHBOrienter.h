//
//  RHBOrienter.h
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 5/28/16.
//
//

#import <UIKit/UIKit.h>


@class RHBOrienter;

@protocol RHBOrienterDelegate <NSObject>

- (void)didChangeDeviceOrientation:(RHBOrienter *)orienter oldOrientation:(UIDeviceOrientation)oldOrientation newOrientation:(UIDeviceOrientation)newOrientation;

@end


@interface RHBOrienter : NSObject

//zTrashold between 0 and 1, and angleTrashold from 0 to 22.5, defaults are 0.85 and 12
- (instancetype)initWithInitialOrientation:(UIDeviceOrientation)initialOrientation zTrashold:(double)zTrashold angleTrashold:(double)angleTrashold;

@property (nonatomic, readonly) UIDeviceOrientation deviceOrientation;
@property (nonatomic, weak) id<RHBOrienterDelegate> delegate;

@end
