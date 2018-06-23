//
//  ViewController.m
//  VideoCollage
//
//  Created by MacBook Pro Retina on 16/6/18.
//  Copyright © 2018 MacBook Pro Retina. All rights reserved.
//

#import "ViewController.h"
#import "CollageStore.h"
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SoundManager.h"
#import "AudioController.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)


@interface ViewController ()<CollageStoreViewDelegate,UIImagePickerControllerDelegate>

{
    
    UIView *viewForButton;
    UIScrollView *scrollViewForButton;
    NSArray *buttonName;
    double heightForBottomView;
    double valueNeedToUpTheStyle;
    NSURL *plistUrlForCollege;
    NSArray *productIdsForCollege;
    
    
    NSURL *plistUrlForRatio;
    NSArray *productIdsForRatio;
    
    int currentIndexForLayout;
    BOOL forFirstLayout;
    double paddingBetweenBox;
    NSMutableArray *collageViewContainerArray;
    double cornerRadius;
    int currentIndexForSelectingVideo;
    AVPlayerViewController *currentViewController;
    __weak IBOutlet UIImageView *imageViewForBackGroundImage;
    __weak IBOutlet UIView *gapViewForIphoneX;
    __weak IBOutlet UIView *viewForStyle;
    __weak IBOutlet UIView *squareView;
    __weak IBOutlet NSLayoutConstraint *topSpaceOfSquareView;
    AVAssetExportSession *assetExport;
    NSArray *currentArrayOfboder;
    NSArray *colorArrayForCollegeView;
    int current_v;
    __weak IBOutlet NSLayoutConstraint *heightForView;
    double extraPoint;
    
    __weak IBOutlet NSLayoutConstraint *widthForView;
    int lastIndexForStyle;
}
@property (strong, nonatomic) AudioController *audioController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceOfStyleLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstrainForBottomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lastIndexForStyle=0;
    
    self.audioController = [[AudioController alloc] init];
   // [self.audioController tryPlayMusic];
    
    colorArrayForCollegeView = [[NSArray alloc] initWithObjects:
                                [UIColor colorWithRed:95/255.0 green:125/255.0 blue:140/255.0 alpha:1.0],
                                [UIColor colorWithRed: 158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0],
                                [UIColor colorWithRed:122/255.0 green:85/255.0 blue:71/255.0 alpha:1.0],
                                [UIColor colorWithRed:255/255.0 green:87/255.0 blue:7/255.0 alpha:1.0],
                                [UIColor colorWithRed:255/255.0 green:153/255.0 blue:0/255.0 alpha:1.0],
                                [UIColor colorWithRed:255/255.0 green:194/255.0 blue:0/255.0 alpha:1.0],
                                [UIColor colorWithRed:255/255.0 green:237/255.0 blue:24/255.0 alpha:1.0],
                                [UIColor colorWithRed:205/255.0 green:222/255.0 blue:32/255.0 alpha:1.0],
                                [UIColor colorWithRed:71/255.0 green:176/255.0 blue: 76/255.0 alpha:1.0],
                                [UIColor colorWithRed:0/255.0 green:151/255.0 blue:136/255.0 alpha:1.0],
                                [UIColor colorWithRed:0/255.0 green:188/255.0 blue:214/255.0 alpha:1.0],
                                [UIColor colorWithRed:0/255.0 green:167/255.0 blue:247/255.0 alpha:1.0],
                                [UIColor colorWithRed:17/255.0 green:148/255.0 blue:246/255.0 alpha:1.0],
                                [UIColor colorWithRed:62/255.0 green:78/255.0 blue:184/255.0 alpha:1.0],
                                [UIColor colorWithRed:103/255.0 green:52/255.0 blue:186/255.0 alpha:1.0],
                                [UIColor colorWithRed:157/255.0 green:27/255.0 blue:178/255.0 alpha:1.0],
                                [UIColor colorWithRed:236/255.0 green:21/255.0 blue:97/255.0 alpha:1.0],
                                [UIColor colorWithRed:247/255.0 green:65/255.0 blue:45/255.0 alpha:1.0],nil];
    
    
    if(collageViewContainerArray==nil)
    {
        collageViewContainerArray=[[NSMutableArray alloc]init];
        for(int j=0;j<10;j++)
        {
            
            CollageStore* obj=[[CollageStore alloc]init];
            [collageViewContainerArray addObject:obj];
            [squareView addSubview:obj];
        }
    }
    currentIndexForLayout=0;
    paddingBetweenBox=5;
    cornerRadius=0;
    buttonName = @[@"Styles", @"Sticker", @"Emoji",@"Filter",@"Font",@"Edit",@"Tools"];
    [self performSelector:@selector(createUI) withObject:self afterDelay:0.1];
    heightForBottomView=(110*self.view.frame.size.width)/750.0;
    plistUrlForCollege = [[NSBundle mainBundle] URLForResource:@"collage" withExtension:@"plist"];
    productIdsForCollege = [NSArray arrayWithContentsOfURL:plistUrlForCollege];
    
    
    plistUrlForRatio = [[NSBundle mainBundle] URLForResource:@"ratio" withExtension:@"plist"];
    productIdsForRatio = [NSArray arrayWithContentsOfURL:plistUrlForRatio];
    
    
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)createUI
{
    
   
    
     extraPoint=20;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (screenSize.height == 812)
        {
            
        }
        else{
            extraPoint=0;
        }
        
    }
    else{
        extraPoint=0;
    }
    
    viewForButton =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-heightForBottomView-extraPoint,self.view.frame.size.width , heightForBottomView)];
    
    valueNeedToUpTheStyle=extraPoint+viewForButton.frame.size.height;
    _bottomSpaceOfStyleLayout.constant=valueNeedToUpTheStyle;
    
    [self.view addSubview:viewForButton];
    
     heightForView.constant=self.view.frame.size.width;
    widthForView.constant=self.view.frame.size.width;
    scrollViewForButton=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, viewForButton.frame.size.height)];
    [viewForButton addSubview:scrollViewForButton];
    
    double topSpace=(self.view.frame.size.height-extraPoint-viewForButton.frame.size.height-self.view.frame.size.width)/2.0;
    topSpaceOfSquareView.constant=topSpace;
    
    for(int i=0;i<7;i++)
    {
        
        
        float heightForEveryButton=(80*(self.view.frame.size.width))/750;
        
        float gapForLabel=(10*(self.view.frame.size.width))/750;
        float labelHeight=(30*(self.view.frame.size.width))/750;
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(i*(self.view.frame.size.width)/5, 0, self.view.frame.size.width/5,viewForButton.frame.size.height)];
        
        
        UIButton *buttontransParent=[[UIButton alloc]initWithFrame:CGRectMake(i*(self.view.frame.size.width)/5, 0, self.view.frame.size.width/5,viewForButton.frame.size.height)];
        
        
        
        UILabel*labelForButtonName=[[UILabel alloc]initWithFrame:CGRectMake(0,v.frame.size.height-labelHeight-gapForLabel, v.frame.size.width,labelHeight)];
        
        
        UIButton*buttonForChangingView=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width/5-heightForEveryButton)/2,0,heightForEveryButton,heightForEveryButton)];
        
        [buttonForChangingView addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [buttontransParent addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonForChangingView.tag=8000+i;
        buttontransParent.tag=8000+i;
        
        
        
        [scrollViewForButton addSubview:v];
        [scrollViewForButton addSubview:buttontransParent];
        
        [v addSubview:labelForButtonName];
        [v addSubview:buttonForChangingView];
        [buttonForChangingView setBackgroundImage:[UIImage imageNamed:buttonName[i]] forState:UIControlStateNormal];
        labelForButtonName.text=buttonName[i];
        [labelForButtonName setFont: [labelForButtonName.font fontWithSize: 10]];
        labelForButtonName.textAlignment = NSTextAlignmentCenter;
    }
    [self.view sendSubviewToBack:viewForStyle];
    [self.view bringSubviewToFront:viewForButton];
    [self.view bringSubviewToFront:gapViewForIphoneX];
    
    [scrollViewForButton setContentSize:CGSizeMake(7*(self.view.frame.size.width)/5, scrollViewForButton.frame.size.height)];
    scrollViewForButton.showsHorizontalScrollIndicator = NO;
    scrollViewForButton.showsVerticalScrollIndicator = NO;
    viewForButton.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:248.0/255.0 alpha:1.0];
    gapViewForIphoneX.backgroundColor=viewForButton.backgroundColor;
    
    
    [self updateAllFramesForCollage:0];
    UIButton *buttonForLayout=(UIButton *)[self.view viewWithTag:8000];
    [self changeView:buttonForLayout];
    
}
-(void)changeView:(id)sender
{
    
    UIButton *button1=(UIButton*)sender;
    int index=(int)(button1.tag-8000);
    if(index==0)
    {
        [self chnageConstrain:_bottomSpaceOfStyleLayout];
    }
    
    
    
}
-(void)chnageConstrain:(NSLayoutConstraint*)constrain
{
    double v=constrain.constant;
    if(v>0)
    {
        v=-600;
    }else{
        v=valueNeedToUpTheStyle;
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         constrain.constant=v;
                         [self.view  layoutIfNeeded];
                     }];
    
    
}

#pragma mark - collectionView delegate & DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if([collectionView isEqual:collectionViewForStyle])
        return productIdsForCollege.count;
    else if([collectionView isEqual:collectionViewForColor])
    {
        return  colorArrayForCollegeView.count;
    }
    else if([collectionView isEqual:collectionViewForRatio])
    {
        return productIdsForRatio.count;
    }
        
        return 0;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UIImageView *backgroundImage = [cell viewWithTag:2000];
    
    if(backgroundImage == nil)
    {
        backgroundImage = [[UIImageView alloc] initWithFrame:cell.bounds];
        backgroundImage.tag = 2000;
        [cell addSubview:backgroundImage];
        backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        backgroundImage.clipsToBounds = YES;
    }
    NSString *name=[NSString stringWithFormat:@"%d%@",(int)indexPath.row+1,@"c.png"];
    UIImage* img = [UIImage imageNamed:name];
    
    if([collectionView isEqual:collectionViewForStyle])
        backgroundImage.image = img;
    else if([collectionView isEqual:collectionViewForColor])
        backgroundImage.backgroundColor=colorArrayForCollegeView[indexPath.row];
    else
        
    {
        backgroundImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld%@",(long)indexPath.row+1,@".png"]];
    }
        
    UIImageView *lockImage= [cell viewWithTag:2001];
    
    
    if(lockImage == nil)
    {
        lockImage=[[UIImageView alloc]initWithFrame:CGRectMake(backgroundImage.frame.size.width-15,2, 15,15)];
        lockImage.tag = 2001;
        lockImage.image=[UIImage imageNamed:@"whitelock.png"];
        [cell addSubview:lockImage];
        lockImage.hidden=YES;
        
    }
    
    
    if([collectionView isEqual:collectionViewForColor])
    {
        cell.layer.cornerRadius=cell.contentView.frame.size.width/2.0;
    }
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if([collectionView isEqual:collectionViewForStyle])
    {
        currentIndexForLayout=(int)indexPath.row;
        CollageStore  *obj;
        NSDictionary *dict=productIdsForCollege[indexPath.row];
        NSArray *arr=[dict objectForKey:@"box"];
        for(int j=(int)arr.count;j<collageViewContainerArray.count;j++)
        {
            obj=collageViewContainerArray[j];
            obj.hidden=YES;
            obj.viewForCollage.hidden=YES;
            
        }
        currentIndexForLayout=(int)indexPath.row;
        [self updateAllFramesForCollage:(int)indexPath.row];
    }
    else if([collectionView isEqual:collectionViewForColor]){
        imageViewForBackGroundImage.backgroundColor=colorArrayForCollegeView[indexPath.row];
    }
    else{
        [self updateSquareView:(int)indexPath.row];
    }
}
-(void)updateSquareView:(int)index
{
    NSDictionary *dic1=productIdsForRatio[index];
    NSArray *testArray = [[dic1 objectForKey:@"Ratio"] componentsSeparatedByString:@":"];
    
    double temp_height=[testArray [1] doubleValue]/[testArray[0] doubleValue];
    temp_height=temp_height*self.view.frame.size.width;
    
    
      double topSpace=(self.view.frame.size.height-extraPoint-viewForButton.frame.size.height-temp_height)/2.0;
    
    if(topSpace<0)
    {
        heightForView.constant=self.view.frame.size.height-extraPoint-viewForButton.frame.size.height;
        
        double temp_width=[testArray [0] intValue]/[testArray[1] intValue];
        temp_width=temp_width* heightForView.constant;
        widthForView.constant=temp_width;
        
        
        
    }
    else{
        heightForView.constant=temp_height;
    }
    
     [self updateAllFramesForCollage:currentIndexForLayout];
    
    
    
}
-(void)updateAllFramesForCollage:(int)index
{
    NSDictionary *dict=productIdsForCollege[index];
    NSArray *arr=[dict objectForKey:@"box"];
    int v=0;
    for(int i=0;i<arr.count;i++)
    {
        v++;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            NSString *temp = arr[i];
            NSArray *testArray = [temp componentsSeparatedByString:@","];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                self->currentArrayOfboder=testArray;
                self->current_v=v;
                [self updateCurrentCollageForFrame:testArray withValue:v];
                
            });
        });
    }
}
-(void)updateCurrentCollageForFrame:(NSArray*)_array withValue:(int)v
{
    
    NSLog(@"%s","hellO");
    float x=[_array[0] doubleValue];
    float y=[_array[1] doubleValue];
    float width=[_array[2] doubleValue];
    float height=[_array[3] doubleValue];
    
    float everyWidth=squareView.frame.size.width/3;
    float everyheight=(squareView.frame.size.height)/3;
    UIColor *color;
    if(v==1)
    {
        color=[UIColor greenColor];
    }
    else if(v==2)
    {
        color=[UIColor blueColor];
    }
    else if(v==3)
    {
        color=[UIColor cyanColor];
    }
    else if(v==4)
    {
        color=[UIColor blackColor];
    }
    else if(v==5)
    {
        color=[UIColor magentaColor];
    }
    else if(v==6)
    {
        color=[UIColor purpleColor];
    }
    else if(v==7)
    {
        color=[UIColor greenColor];
    }
    else if(v==8)
    {
        color=[UIColor yellowColor];
    }
    else if(v==9)
    {
        color=[UIColor orangeColor];
        
    }
    
    CollageStore *obj;
    obj=collageViewContainerArray[v];
    obj.hidden=NO;
    
    double lp,tp,rp,bp;
    
    
    if(x==0)
    {
        lp=paddingBetweenBox;
    }
    else{
        lp=paddingBetweenBox/2.0;
    }
    if(y==0)
    {
        tp=paddingBetweenBox;
    }
    else{
        tp=paddingBetweenBox/2.0;
    }
    
    if(x+width==3)
    {
        rp=paddingBetweenBox;
    }
    else
        rp=paddingBetweenBox/2.0f;
    
    if(y+height==3)
    {
        bp=paddingBetweenBox;
    }
    else
        bp=paddingBetweenBox/2.0f;
    
    CGRect frame_n = CGRectMake(x*everyWidth + lp, y*everyheight + tp, everyWidth*width - rp - lp, everyheight*height - bp - tp);
    
    
    obj.x=x*everyWidth+lp;
    obj.y=y*everyheight+tp;
    obj.width=everyWidth*width - rp - lp;
    obj.height=everyheight*height - bp - tp;
    obj.frame=frame_n;
    [obj.viewForCollage setFrame:CGRectMake(0, 0, frame_n.size.width, frame_n.size.height)];
    obj.viewForCollage.backgroundColor=color;
    [obj.buttonForSelectingVideo setFrame:obj.viewForCollage.bounds];
    obj.viewForCollage.hidden=NO;
    obj.layer.cornerRadius = cornerRadius;
    obj.layer.masksToBounds = true;
    [obj setClipsToBounds:YES];
    [obj.viewForCollage setClipsToBounds:YES];
    obj.delegate = self;
    obj.viewForCollage.tag=v+90000;
    obj.buttonForSelectingVideo.tag=v+80000;
    obj.playerViewController.view.frame=obj.viewForCollage.bounds;
    currentViewController=obj.playerViewController;
    
    
    
}
- (void)  changingVideo:(id)sender
{
    UIButton *btn=sender;
    currentIndexForSelectingVideo=(int)btn.tag-80000;
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    videoPicker.delegate = self;
    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [self presentViewController:videoPicker animated:YES completion:nil];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSURL * url =[info objectForKey:UIImagePickerControllerMediaURL];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CollageStore *obj;
        obj=self->collageViewContainerArray[self->currentIndexForSelectingVideo];
        obj.buttonForSelectingVideo.hidden=YES;
        obj.asset=[AVURLAsset assetWithURL:url];
        AVPlayer *player = [AVPlayer playerWithURL:url];
        obj.playerViewController.player = player;
        
        
        
        
    });
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    
    
    
}

- (IBAction)gotoExport:(id)sender
{
    
}

- (IBAction)chnageDistanceBetweenBox:(UISlider *)sender {
    
    paddingBetweenBox=sender.value;
    [self updateAllFramesForCollage:currentIndexForLayout];
    
}
- (IBAction)changedCornerRadius:(UISlider *)sender {
    cornerRadius=sender.value;
    [self updateAllFramesForCollage:currentIndexForLayout];
    
}

@end
