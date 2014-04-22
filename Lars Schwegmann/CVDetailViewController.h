//
//  CVDetailViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 13.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

//---------------------------------------------------------------------------------------------------------------

@interface CVDetailViewController : UIViewController

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImage *image;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

//---------------------------------------------------------------------------------------------------------------