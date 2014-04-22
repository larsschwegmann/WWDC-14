//
//  CVDetailViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 13.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "CVDetailViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface CVDetailViewController ()

@end

//---------------------------------------------------------------------------------------------------------------

@implementation CVDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Setup TextView
    if (_text)
        [_textView setText:_text];
    
    _textView.textAlignment = NSTextAlignmentJustified;
    _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:19.0f];
    _textView.dataDetectorTypes = UIDataDetectorTypeLink;
    //Setup Image View
    if (_image)
        [_headerImageView setImage:_image];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

@end
