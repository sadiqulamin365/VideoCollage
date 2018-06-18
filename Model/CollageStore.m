//
//  CollageStore.m
//  MemeMaker
//
//  Created by Sadiq on 7/13/17.
//  Copyright © 2017 BRAINCRAFT. All rights reserved.
//

#import "CollageStore.h"
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#define MINIMUM_SCALE 0.4
#define MAXIMUM_SCALE 6.0
@implementation CollageStore
{
    
}

@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
         
        [self setVideoPlayBackViewPosition];
       
    }
    return self;
}


-(void)setBackgroundCol:(UIColor *)backgroundColor
{
    
    self.backgroundColor=backgroundColor;
}

-(void)setVideoPlayBackViewPosition
{
    _viewForCollage=[[UIView alloc]initWithFrame:CGRectZero];
    _buttonForSelectingVideo=[[UIButton alloc]initWithFrame:CGRectZero];
    [_buttonForSelectingVideo addTarget:self action:@selector(changingVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_viewForCollage];
    _playerViewController = [AVPlayerViewController new];
    _playerViewController.videoGravity= AVLayerVideoGravityResizeAspectFill;
    [_viewForCollage addSubview:_playerViewController.view];
    [self addSubview:_buttonForSelectingVideo];
    _v++;
}

- (void)  changingVideo:(id)sender
{
    [self.delegate changingVideo:sender];
}

#pragma mark Gesture Works


-(void)selectThisView
{
   
    [self.delegate collageView:self selectedWithTag:self.viewForCollage.tag];
    self.layer.borderWidth = 2.0;
}

-(void)deselectThisView
{
    self.layer.borderWidth = 0.0;
}

 @end
