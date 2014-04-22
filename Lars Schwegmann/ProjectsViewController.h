//
//  ProjectsViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 10.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

#import "FXBlurView.h"

#import "ProjectsDetailViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface ProjectsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//---------------------------------------------------------------------------------------------------------------