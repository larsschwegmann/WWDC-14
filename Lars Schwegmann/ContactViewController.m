//
//  ContactViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 13.04.14.
//
//

//------------------------------------------------------------------------------------

#import "ContactViewController.h"

//------------------------------------------------------------------------------------

@interface ContactViewController ()

@property (nonatomic, strong) NSArray *tableItems;

@end

//------------------------------------------------------------------------------------

@implementation ContactViewController

//------------------------------------------------------------------------------------
#pragma mark - UIViewController Methods
//------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    _tableItems = @[
                    @{@"type":@"iPhone", @"value":@"49-160-94420035"},
                    @{@"type":@"Home", @"value":@"49-208-3029848"},
                    @{@"type":@"Email", @"value":@"schwegmannlars@gmail.com"},
                    @{@"type":@"Twitter", @"value":@"@larsschwegmann"},
                    @{@"type":@"Web", @"value":@"http://larsschwegmann.com"}
                    ];
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

- (IBAction)addButtonPressed:(id)sender {
    ABRecordRef person = ABPersonCreate();
    ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFStringRef) @"Lars", NULL);
    ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFStringRef) @"Schwegmann", NULL);
    ABRecordSetValue(person, kABPersonJobTitleProperty, (__bridge CFStringRef) @"iOS Developer", NULL);
    ABMutableMultiValueRef phoneMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phoneMultiValue, (__bridge CFStringRef) @"+4916094420035", kABPersonPhoneIPhoneLabel, NULL);
    ABMultiValueAddValueAndLabel(phoneMultiValue, (__bridge CFStringRef) @"+4920894420035", kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(person, kABPersonPhoneProperty, phoneMultiValue, nil);
    CFRelease(phoneMultiValue);
    ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(emailMultiValue, (__bridge CFStringRef) @"schwegmannlars@gmail.com", kABWorkLabel, NULL);
    ABRecordSetValue(person, kABPersonEmailProperty, emailMultiValue, nil);
    CFRelease(emailMultiValue);
    
    ABUnknownPersonViewController *controller = [[ABUnknownPersonViewController alloc] init];
    
    controller.displayedPerson = person;
    controller.allowsAddingToAddressBook = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
    CFRelease(person);
}

//------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

//------------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    cell.textLabel.text = [cellContents objectForKey:@"type"];
    cell.detailTextLabel.text = [cellContents objectForKey:@"value"];
    return cell;
}

//------------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//------------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"iPhone"] || [[cellContents objectForKey:@"type"] isEqualToString:@"Home"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [cellContents objectForKey:@"value"]]]];
    }
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"Email"]){
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setToRecipients:@[@"schwegmannlars@gmail.com"]];
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"Twitter"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", [[cellContents objectForKey:@"value"] stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""]]]];
    }
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"Web"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[cellContents objectForKey:@"value"]]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//------------------------------------------------------------------------------------
#pragma mark - MFMailComposeDelegate
//------------------------------------------------------------------------------------

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//------------------------------------------------------------------------------------