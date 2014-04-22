//
//  ZoomSegue.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 07.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "ZoomSegue.h"

//---------------------------------------------------------------------------------------------------------------

#define CATransform3DPerspective(t, x, y) (CATransform3DConcat(t, CATransform3DMake(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, 0, 0, 0, 0, 1)))
#define CATransform3DMakePerspective(x, y) (CATransform3DPerspective(CATransform3DIdentity, x, y))

CG_INLINE CATransform3D
CATransform3DMake(CGFloat m11, CGFloat m12, CGFloat m13, CGFloat m14,
				  CGFloat m21, CGFloat m22, CGFloat m23, CGFloat m24,
				  CGFloat m31, CGFloat m32, CGFloat m33, CGFloat m34,
				  CGFloat m41, CGFloat m42, CGFloat m43, CGFloat m44)
{
	CATransform3D t;
	t.m11 = m11; t.m12 = m12; t.m13 = m13; t.m14 = m14;
	t.m21 = m21; t.m22 = m22; t.m23 = m23; t.m24 = m24;
	t.m31 = m31; t.m32 = m32; t.m33 = m33; t.m34 = m34;
	t.m41 = m41; t.m42 = m42; t.m43 = m43; t.m44 = m44;
	return t;
}

//---------------------------------------------------------------------------------------------------------------

@implementation ZoomInSegue

//------------------------------------------------------------------------------------
#pragma mark - UIStoryboardSegue Methods
//------------------------------------------------------------------------------------

- (void)perform{
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination = (UIViewController *)self.destinationViewController;
    
    UIWindow *mainWindow = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    
    destination.view.alpha = 0.0f;
    [mainWindow addSubview:destination.view];
    CATransform3D scaleTransform = CATransform3DMakeScale(0.75f, 0.75f, 1.0f);
    destination.view.layer.transform = scaleTransform;
    [destination.view setCenter:CGPointMake(destination.view.center.x, destination.view.center.y + 200)];
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        source.view.alpha = 0.0f;
        CATransform3D scaleTransform = CATransform3DMakeScale(0.75f, 0.75f, 1.0f);
        CATransform3D perspectiveTransform = CATransform3DMakePerspective(0, -0.001f);
        source.view.layer.transform = CATransform3DConcat(scaleTransform, perspectiveTransform);
        destination.view.alpha = 1.0f;
        [destination.view setCenter:CGPointMake(destination.view.center.x, destination.view.center.y - 200)];
        destination.view.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished){
        [destination.view removeFromSuperview];
        [source presentViewController:destination animated:NO completion:nil];
        [source.view.layer setTransform:CATransform3DIdentity];
    }];
}

@end

//---------------------------------------------------------------------------------------------------------------

@implementation ZoomOutUnwindSegue

//------------------------------------------------------------------------------------
#pragma mark - UIStoryboardSegue Methods
//------------------------------------------------------------------------------------

- (void)perform{
    UIViewController *source = (UIViewController *)self.sourceViewController;
    if (source.navigationController != nil)
        source = source.navigationController;
    UIViewController *destination = (UIViewController *)self.destinationViewController;
    
    UIWindow *mainWindow = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    
    destination.view.alpha = 0.0f;
    [mainWindow addSubview:destination.view];
    CATransform3D scaleTransform = CATransform3DMakeScale(0.75f, 0.75f, 1.0f);
    CATransform3D perspectiveTransform = CATransform3DMakePerspective(0, -0.001f);
    destination.view.layer.transform = CATransform3DConcat(scaleTransform, perspectiveTransform);
    
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        source.view.alpha = 0.0f;
        source.view.layer.transform = CATransform3DMakeScale(0.75f, 0.75f, 1.0f);
        source.view.center = CGPointMake(source.view.center.x, source.view.center.y + 200);
        destination.view.alpha = 1.0f;
        destination.view.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished){
        [destination.view removeFromSuperview];
        [source.view.layer setTransform:CATransform3DIdentity];
        [source.view setCenter:CGPointMake(source.view.center.x, source.view.center.y - 200)];
        [destination dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end

//---------------------------------------------------------------------------------------------------------------