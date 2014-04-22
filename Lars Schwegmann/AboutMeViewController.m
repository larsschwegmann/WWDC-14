//
//  AboutMeViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 07.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "AboutMeViewController.h"

#import "AppDelegate.h"

//---------------------------------------------------------------------------------------------------------------

@interface AboutMeViewController ()

@end

//---------------------------------------------------------------------------------------------------------------

@implementation AboutMeViewController

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UIViewController Methods
//---------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_contentScrollView flashScrollIndicators];
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

@end

//---------------------------------------------------------------------------------------------------------------