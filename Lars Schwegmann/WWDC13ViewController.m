//
//  WWDC13ViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 12.04.14.
//
//

//------------------------------------------------------------------------------------

#import "WWDC13ViewController.h"

//------------------------------------------------------------------------------------

@interface WWDC13ViewController ()

@end

//------------------------------------------------------------------------------------

@implementation WWDC13ViewController

//------------------------------------------------------------------------------------
#pragma mark - UIViewcontroller Methods
//------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Setup Pictures Button
    [_picturesButton setImage:[UIImage imageNamed:@"Detail Indicator White"] forState:UIControlStateHighlighted];
    [_picturesButton setImage:[UIImage imageNamed:@"Detail Indicator White"] forState:UIControlStateSelected];
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

//------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[GalleryViewController class]]){
        GalleryViewController *destination = (GalleryViewController *)segue.destinationViewController;
        [destination setImageBundleName:@"wwdc13"];
    }
}

@end

//------------------------------------------------------------------------------------