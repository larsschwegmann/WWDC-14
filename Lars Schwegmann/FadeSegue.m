//
//  FadeSegue.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 05.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "FadeSegue.h"

//---------------------------------------------------------------------------------------------------------------

@implementation FadeSegue

//------------------------------------------------------------------------------------
#pragma mark - UIStoryboardSegue Methods
//------------------------------------------------------------------------------------

- (void)perform{
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination = (UIViewController *)self.destinationViewController;
    
    destination.view.alpha = 0.0f;
    [source.view addSubview:destination.view];
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        destination.view.alpha = 1.0f;
    }completion:^(BOOL finished){
        if (finished){
            [destination.view removeFromSuperview];
            [source presentViewController:destination animated:NO completion:nil];
        }
    }];
}

@end

//---------------------------------------------------------------------------------------------------------------