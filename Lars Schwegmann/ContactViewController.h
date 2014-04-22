//
//  ContactViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 13.04.14.
//
//

//------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "RotationNavigationController.h"

//------------------------------------------------------------------------------------

@interface ContactViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addButtonPressed:(id)sender;

@end

//------------------------------------------------------------------------------------