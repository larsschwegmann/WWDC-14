//
//  MainViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 03.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "MainViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface MainViewController ()

@property UITapGestureRecognizer *tapGestureRecognizer;
@property UIPanGestureRecognizer *panGestureRecognizer;
@property UIDynamicAnimator *animator;
@property UICollisionBehavior *collisionBehavior;
@property UIAttachmentBehavior *attachBehavior;
@property UIPushBehavior *pushBehavior;
@property CGPoint originalCenterOfHelloView;

@property NSArray *allConstraints;

- (void)handleTapGesture:(id)sender;
- (void)handlePanGesture:(id)sender;

@end

//---------------------------------------------------------------------------------------------------------------

@implementation MainViewController

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UIViewController Methods
//---------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Setup Blur View
    [_blurView setTintColor:[UIColor clearColor]];
    [_blurView setBlurEnabled:YES];
    [_blurView setDynamic:NO];
    [_blurView setBlurRadius:10.0f];
    [_blurView setAlpha:0.0f];
    
    //Setup Hello View
    //[_helloView setBlurEnabled:YES];
    //[_helloView setDynamic:YES];
    //[_helloView setTintColor:[UIColor colorWithRed:0.06 green:0.49 blue:0.96 alpha:1]];
    //[_helloView setBlurRadius:100.0f];
    [_helloView setAlpha:1.0f];
    [_helloView.layer setMasksToBounds:YES];
    [_helloView.layer setCornerRadius:12.0f];
    
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
    horizontalMotionEffect.minimumRelativeValue = @(-10);
    horizontalMotionEffect.maximumRelativeValue = @(10);
    
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    [_backgroundContainerView addMotionEffect:group];
    
    //Add Gesture Recognizers + Animators
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    
    _allConstraints = @[_constraint1, _constraint2, _constraint3, _constraint4, _constraint5];
    
    //TODO: fix this bug and use dynamic values instead of these constants
    if (IS_IPHONE5){
        _originalCenterOfHelloView = CGPointMake(160, 458);
    }else{
        _originalCenterOfHelloView = CGPointMake(160, 370);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view removeConstraints:_allConstraints];
    CGPoint center = _helloView.center;
    [_helloView setCenter:CGPointMake(center.x + 300, center.y + 600)];
    _helloView.transform = CGAffineTransformMakeRotation(M_PI);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
        _blurView.alpha = 0.0f;
    }completion:^(BOOL finished){
        if (finished){
            [UIView animateWithDuration:0.5f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [_helloView setCenter:_originalCenterOfHelloView];
                _helloView.transform = CGAffineTransformIdentity;
            }completion:^(BOOL finished){
                if (finished){
                    [self.view addConstraints:_allConstraints];
                    [self.view addGestureRecognizer:_tapGestureRecognizer];
                    [self.view addGestureRecognizer:_panGestureRecognizer];
                }
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

- (void)showMenu{
    [self performSegueWithIdentifier:@"fadeToMenu" sender:self];
}

- (void)hideHelloView{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _helloView.alpha = 0.0f;
        //_blurView.alpha = 1.0f;
    }completion:^(BOOL finished){
        [self showMenu];
    }];
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Gesture Recognizers
//---------------------------------------------------------------------------------------------------------------

- (void)handleTapGesture:(id)sender{
    [self hideHelloView];
}

- (void)handlePanGesture:(id)sender{
    CGPoint p = [_panGestureRecognizer locationInView:self.view];
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan){
        [self.view removeConstraints:_allConstraints];
        CGPoint center = _helloView.center;
        UIOffset offset = UIOffsetMake(p.x - center.x, p.y - center.y);
        _attachBehavior = [[UIAttachmentBehavior alloc] initWithItem:_helloView offsetFromCenter:offset attachedToAnchor:p];
        [_animator addBehavior:_attachBehavior];
    }else if (_panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        _attachBehavior.anchorPoint = p;
    }else if ((_panGestureRecognizer.state == UIGestureRecognizerStateEnded || _panGestureRecognizer.state == UIGestureRecognizerStateCancelled) && _attachBehavior) {
        [_animator removeBehavior:_attachBehavior];
        _attachBehavior = nil;
        
        CGPoint velocity = [_panGestureRecognizer velocityInView:self.view];
        velocity = CGPointMake(velocity.x / 30, velocity.y / 30);
        CGFloat magnitude = (CGFloat)sqrt(pow((double)velocity.x, 2.0) + pow((double)velocity.y, 2.0));
        if (magnitude > 30) {
            _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_helloView]];
            _collisionBehavior.collisionDelegate = self;
            CGFloat diagonal = -sqrt(pow(CGRectGetWidth(_helloView.frame), 2.0) + pow(CGRectGetHeight(_helloView.frame), 2.0));
            UIEdgeInsets insets = UIEdgeInsetsMake(diagonal, diagonal, diagonal, diagonal);
            [_collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:insets];
            [_animator addBehavior:_collisionBehavior];
            
            _pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_helloView] mode:UIPushBehaviorModeInstantaneous];
            CGPoint center = _helloView.center;
            UIOffset offset = UIOffsetMake((p.x - center.x) / 2.0, (p.y - center.y) / 2.0);
            [_pushBehavior setTargetOffsetFromCenter:offset forItem:_helloView];
            _pushBehavior.pushDirection = CGVectorMake(velocity.x, velocity.y);
            [_animator addBehavior:_pushBehavior];
            
            _panGestureRecognizer.enabled = NO;
        }else{
            [UIView animateWithDuration:0.25f animations:^{
                _helloView.center = _originalCenterOfHelloView;
                _helloView.transform = CGAffineTransformIdentity;
            }completion:^(BOOL finished){
                if (finished)
                    [self.view addConstraints:_allConstraints];
            }];
        }
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)pq{
    [_animator removeAllBehaviors];
    _pushBehavior = nil;
    _collisionBehavior = nil;
    [_helloView setHidden:YES];
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //_blurView.alpha = 1.0f;
    }completion:^(BOOL finished){
        [self showMenu];
    }];
}

@end

//---------------------------------------------------------------------------------------------------------------