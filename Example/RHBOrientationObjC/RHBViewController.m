//
//  RHBViewController.m
//  RHBOrientationObjC
//
//  Created by Lazar Otasevic on 05/31/2016.
//  Copyright (c) 2016 Lazar Otasevic. All rights reserved.
//

#import "RHBViewController.h"
#import "RHBOrientation.h"


@interface RHBViewController ()<RHBOrienterDelegate>

@property (nonatomic) RHBOrienter *orienter;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation RHBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.orienter = [RHBOrienter new];
    self.orienter.delegate = self;
}

#pragma mark RHBOrienterDelegate

-(void)didChangeDeviceOrientation:(RHBOrienter *)orienter oldOrientation:(UIDeviceOrientation)oldOrientation newOrientation:(UIDeviceOrientation)newOrientation {
    
    CGFloat rotationAngle = [RHBOrientationUtilities rotationAngleWithDeviceOrientation:newOrientation];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.imageView.transform = CGAffineTransformMakeRotation(rotationAngle);
    }];
}

@end
