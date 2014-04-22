//
//  CVViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 11.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

#import "CVTableBackgroundView.h"

#import "CVDetailViewController.h"
#import "ProjectsDetailViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface CVViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//---------------------------------------------------------------------------------------------------------------