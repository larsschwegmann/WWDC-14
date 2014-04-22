//
//  ProjectsDetailViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 11.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <StoreKit/StoreKit.h>

#import "AppStoreButton.h"

#import "GalleryViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface ProjectsDetailViewController : UIViewController <UIScrollViewDelegate, SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) UIImage *appIconImage;
@property (nonatomic, strong) NSString *appStoreButtonText;
@property (nonatomic) BOOL appStoreButtonEnabled;
@property (nonatomic, strong) NSString *screenshotsButtonText;
@property (nonatomic, strong) NSString *screenshotsBundleName;
@property (nonatomic) BOOL screenshotsButtonEnabled;
@property (nonatomic, strong) NSString *textViewText;
@property (nonatomic, strong) NSURL *appStoreURL;
@property (nonatomic) BOOL isVideoURL;
@property (nonatomic) BOOL showsPongNeueButton; //:)

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet AppStoreButton *screenshotsButton;
@property (weak, nonatomic) IBOutlet AppStoreButton *appStoreButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)appStoreButtonPressed:(id)sender;

@end

//---------------------------------------------------------------------------------------------------------------