//
//  MenuViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 05.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

#import "FXBlurView.h" //-> https://github.com/nicklockwood/FXBlurView
#import "YSViewer.h" //-> https://github.com/yashigani/YSViewer

#import "MenuButton.h"
#import "ZoomSegue.h"

//---------------------------------------------------------------------------------------------------------------

@interface MenuViewController : UIViewController <UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet FXBlurView *blurView;
@property (weak, nonatomic) IBOutlet FXBlurView *avatarBlurView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UIView *alignmentContainerView;

@property (weak, nonatomic) IBOutlet MenuButton *aboutMeButton;
@property (weak, nonatomic) IBOutlet MenuButton *projectsButton;
@property (weak, nonatomic) IBOutlet MenuButton *cvButton;
@property (weak, nonatomic) IBOutlet MenuButton *wwdcButton;
@property (weak, nonatomic) IBOutlet MenuButton *contactButton;

- (IBAction)showBigAvatarImage:(id)sender;

@end

//---------------------------------------------------------------------------------------------------------------