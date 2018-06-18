//
//  CollageStore.h
//  MemeMaker
//
//  Created by Sadiq on 7/13/17.
//  Copyright © 2017 BRAINCRAFT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

//#import "ERImageViewGestureController.h"
@protocol CollageStoreViewDelegate <NSObject>
- (void) collageView:(id)view selectedWithTag:(NSInteger)selectedTag;
- (void)  changingVideo:(id)sender;

@end


@interface CollageStore : UIView<UIGestureRecognizerDelegate>
{
    
    
    
    
}
@property (nonatomic, assign) id <CollageStoreViewDelegate> delegate;
@property(nonatomic,strong)UIView *viewForCollage;
@property(nonatomic,strong) AVPlayerViewController *playerViewController;
@property(nonatomic,strong)UIButton *buttonForSelectingVideo;
@property(nonatomic)int v;
@property(nonatomic)double x;
@property(nonatomic)double y;
@property(nonatomic)double width;
@property(nonatomic)double height;
@property(nonatomic,strong) AVAsset *asset;
- (void) setVideoPlayBackViewPosition;
-(void)deselectThisView;



@end
