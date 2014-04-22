//
//  MainViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 03.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

#import "FXBlurView.h" //-> https://github.com/nicklockwood/FXBlurView

//---------------------------------------------------------------------------------------------------------------

@interface MainViewController : UIViewController <UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet FXBlurView *blurView;
@property (weak, nonatomic) IBOutlet UIView *helloView;

- (void)showMenu;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint5;

@end

//---------------------------------------------------------------------------------------------------------------