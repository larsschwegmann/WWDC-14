//
//  ProjectsDetailViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 11.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "ProjectsDetailViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface ProjectsDetailViewController ()

@property (nonatomic, weak) UIImageView *pongNeueImageView;

- (void)refreshControlTriggered:(id)sender;

@end

//---------------------------------------------------------------------------------------------------------------

@implementation ProjectsDetailViewController

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UIViewController Methods
//---------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Setup Icon Image View
    [_iconImageView setImage:_appIconImage];
    [_iconImageView.layer setMasksToBounds:YES];
    [_iconImageView.layer setCornerRadius:30.0f];
    
    //Setup Screenshots button
    _screenshotsButton.enabled = _screenshotsButtonEnabled;
    if (_screenshotsButtonText){
        [_screenshotsButton setTitle:_screenshotsButtonText forState:UIControlStateNormal];
        [_screenshotsButton setTitle:_screenshotsButtonText forState:UIControlStateDisabled];
    }
    [_screenshotsButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    //Setup App Store Button
    _appStoreButton.enabled = _appStoreButtonEnabled;
    if (_appStoreButtonText){
        [_appStoreButton setTitle:_appStoreButtonText forState:UIControlStateNormal];
        [_appStoreButton setTitle:_appStoreButtonText forState:UIControlStateDisabled];
    }
    [_appStoreButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    //Setup Content Text View
    if (_textViewText)
        [_contentTextView setText:_textViewText];
    
    _contentTextView.textAlignment = NSTextAlignmentJustified;
    _contentTextView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:19.0f];
    
    //Pong Neue
    if (_showsPongNeueButton){
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refreshControlTriggered:) forControlEvents:UIControlEventValueChanged];
        [refreshControl setAlpha:0.0f];
        [_scrollView addSubview:refreshControl];
        
        UIImageView *pongNeueImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -60, 320, 60)];
        pongNeueImageView.image = [UIImage imageNamed:@"Pong Neue Refresh Image"];
        pongNeueImageView.backgroundColor = [UIColor blackColor];
        [_scrollView addSubview:pongNeueImageView];
        _pongNeueImageView = pongNeueImageView;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView.delegate = self;
    [_scrollView flashScrollIndicators];
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

- (void)refreshControlTriggered:(id)sender{
    NSLog(@"Pong Neue!");
    UIRefreshControl *refreshControl = (UIRefreshControl *)sender;
    [refreshControl endRefreshing];
    [self performSegueWithIdentifier:@"fadeToGame" sender:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _scrollView.delegate = nil;
}

- (IBAction)appStoreButtonPressed:(id)sender {
    if (_isVideoURL){
        MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:_appStoreURL];
        [self presentMoviePlayerViewControllerAnimated:moviePlayer];
    }else{
        NSDictionary *appParameters = [NSDictionary dictionaryWithObject:@"516314495" forKey:SKStoreProductParameterITunesItemIdentifier];
        SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
        productViewController.delegate = self;
        [productViewController loadProductWithParameters:appParameters completionBlock:nil];
        [self presentViewController:productViewController animated:YES completion:nil];
    }
}

- (void)moviePlaybackDidFinish:(NSNotification *)notification{
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]){
        [player.view removeFromSuperview];
    }
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[GalleryViewController class]]){
        GalleryViewController *destination = (GalleryViewController *)segue.destinationViewController;
        destination.imageBundleName = _screenshotsBundleName;
    }
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UIScrollViewDelegate
//---------------------------------------------------------------------------------------------------------------


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -56.0f){
        CGFloat alphaValue = 1 - ((140 - -offsetY)/(140));
        _pongNeueImageView.alpha = alphaValue;
    }
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - SKStoreProductViewControllerDelegate
//---------------------------------------------------------------------------------------------------------------

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//---------------------------------------------------------------------------------------------------------------