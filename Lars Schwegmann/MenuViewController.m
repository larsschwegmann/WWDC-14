//
//  MenuViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 05.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "MenuViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface MenuViewController ()

@property (nonatomic, strong) YSViewer *imageViewer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

- (void)handleTapGesture:(id)sender;

@end

//---------------------------------------------------------------------------------------------------------------

@implementation MenuViewController

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UIViewController Methods
//---------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setUserInteractionEnabled:NO];
    //Setup Blur View
    [_blurView setTintColor:[UIColor clearColor]];
    [_blurView setBlurEnabled:YES];
    [_blurView setDynamic:NO];
    [_blurView setBlurRadius:10.0f];
    [_blurView setAlpha:0.0f];
    
    //Setup Background Container view
    [_backgroundContainerView setUserInteractionEnabled:YES];
    
    //Setup Avatar Image View
    [_avatarButton.layer setCornerRadius:60.0f];
    [_avatarButton.layer setMasksToBounds:YES];
    [_avatarButton setAlpha:0.0f];
    [_avatarButton setUserInteractionEnabled:YES];
    
    //Setup Avatar Blur View
    [_avatarBlurView setTintColor:[UIColor clearColor]];
    [_avatarBlurView setBlurEnabled:YES];
    [_avatarBlurView setDynamic:YES];
    [_avatarBlurView setUnderlyingView:_backgroundContainerView];
    [_avatarBlurView setBlurRadius:100.0f];
    [_avatarBlurView.layer setCornerRadius:65.0f];
    [_avatarBlurView.layer setMasksToBounds:YES];
    [_avatarBlurView setAlpha:0.0f];
    
    //Setup Name Label
    [_nameLabel setAlpha:0.0f];
    
    //Setup Menu Buttons
    _aboutMeButton.alpha = 0.0f;
    _aboutMeButton.userInteractionEnabled = YES;
    _projectsButton.alpha = 0.0f;
    _projectsButton.userInteractionEnabled = YES;
    _cvButton.alpha = 0.0f;
    _cvButton.userInteractionEnabled = YES;
    _wwdcButton.alpha = 0.0f;
    _wwdcButton.userInteractionEnabled = YES;
    _contactButton.alpha = 0.0f;
    _contactButton.userInteractionEnabled = YES;
    
    //Setup Image Viewer
    _imageViewer = [[YSViewer alloc] init];
    _imageViewer.image = [UIImage imageNamed:@"Avatar Big"];
    
    //Add motion effects to background container view
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-10);
    verticalMotionEffect.maximumRelativeValue = @(10);
    
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-50);
    horizontalMotionEffect.maximumRelativeValue = @(50);
    
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    [_backgroundContainerView addMotionEffect:group];
    
    //Setup Tap Gesture Recognizer
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    _tapGestureRecognizer = tapGestureRecognizer;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5f delay:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _blurView.alpha = 1.0f;
    }completion:^(BOOL finished){
        if (finished){
            [UIView animateWithDuration:0.5f delay:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _avatarButton.alpha = 1.0f;
                _avatarBlurView.alpha = 1.0f;
            }completion:nil];
            [UIView animateWithDuration:0.5f delay:1.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _nameLabel.alpha = 1.0f;
            }completion:nil];
            [UIView animateWithDuration:0.5f delay:1.4f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _aboutMeButton.alpha = 1.0f;
            }completion:nil];
            [UIView animateWithDuration:0.5f delay:1.6f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _projectsButton.alpha = 1.0f;
            }completion:nil];
            [UIView animateWithDuration:0.5f delay:1.8f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _cvButton.alpha = 1.0f;
            }completion:nil];
            [UIView animateWithDuration:0.5f delay:2.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _wwdcButton.alpha = 1.0f;
            }completion:nil];
            [UIView animateWithDuration:0.5f delay:2.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _contactButton.alpha = 1.0f;
            }completion:^(BOOL finished){
                [self.view setUserInteractionEnabled:YES];
                [self.view addGestureRecognizer:_tapGestureRecognizer];
            }];
        }
    }];
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - IBActions
//---------------------------------------------------------------------------------------------------------------

- (IBAction)showBigAvatarImage:(id)sender {
    [_imageViewer show];
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Gesture Rcognizers
//---------------------------------------------------------------------------------------------------------------

- (void)handleTapGesture:(id)sender{
    CGPoint p = [_tapGestureRecognizer locationInView:self.view];
    if ([self.backgroundContainerView hitTest:p withEvent:nil]){
        if (_alignmentContainerView.alpha == 0.0f){
            [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _alignmentContainerView.alpha = 1.0f;
                _blurView.alpha = 1.0f;
            }completion:nil];
        }else{
            [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _alignmentContainerView.alpha = 0.0f;
                _blurView.alpha = 0.0f;
            }completion:nil];
        }
    }
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)unwindFromViewController:(UIStoryboardSegue *)sender {
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    ZoomOutUnwindSegue *zoomUnwindSegue = [[ZoomOutUnwindSegue alloc] initWithIdentifier:@"UnwindToMenu" source:fromViewController destination:toViewController];
    return zoomUnwindSegue;
}

@end

//---------------------------------------------------------------------------------------------------------------