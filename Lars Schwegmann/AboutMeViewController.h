//
//  AboutMeViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 07.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

//---------------------------------------------------------------------------------------------------------------

@interface AboutMeViewController : UIViewController //<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

//---------------------------------------------------------------------------------------------------------------