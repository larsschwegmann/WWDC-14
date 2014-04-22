//
//  GalleryViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 12.04.14.
//
//

//------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

#import "YSViewer.h"

//------------------------------------------------------------------------------------

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSString *imageBundleName;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

//------------------------------------------------------------------------------------