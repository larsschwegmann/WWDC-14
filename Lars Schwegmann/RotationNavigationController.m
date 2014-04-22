//
//  RotationNavigationController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 13.04.14.
//
//

//------------------------------------------------------------------------------------

#import "RotationNavigationController.h"

//------------------------------------------------------------------------------------

@interface RotationNavigationController ()

@end

//------------------------------------------------------------------------------------

@implementation RotationNavigationController

- (BOOL)shouldAutorotate{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}

@end

//------------------------------------------------------------------------------------