//
//  ViewController.h
//  VideoCollage
//
//  Created by MacBook Pro Retina on 16/6/18.
//  Copyright © 2018 MacBook Pro Retina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
    __weak IBOutlet UICollectionView *collectionViewForColor;
    
    __weak IBOutlet UICollectionView *collectionViewForStyle;
    
}

- (IBAction)gotoExport:(id)sender;

 



@end

