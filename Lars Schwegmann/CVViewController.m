//
//  CVViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 11.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "CVViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface CVViewController ()

@property (nonatomic, strong) NSArray *tableItems;
@property (nonatomic, strong) NSArray *detailItems;

@property (nonatomic, strong) NSIndexPath *selectedIndex;

@end

//---------------------------------------------------------------------------------------------------------------

@implementation CVViewController

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UIViewcontroller Methods
//---------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Setup Table Items
    _tableItems = @[
                    @{@"type":@"CVStatusCell", @"text":@"Born on January 12, 1997"},
                    @{@"type":@"CVPastCell", @"text":@"Got interested in Coding", @"lines":[NSNumber numberWithInt:1], @"date":@"2009"},
                    @{@"type":@"CVPastCell", @"text":@"Got my first Mac for Christmas", @"lines":[NSNumber numberWithInt:2], @"date":@"2010"},
                    @{@"type":@"CVPastCell", @"text":@"Published my first App, Pong Reloaded", @"lines":[NSNumber numberWithInt:2], @"date":@"2010"},
                    @{@"type":@"CVStatusCell", @"text":@"Attended WWDC '13"},
                    @{@"type":@"CVStatusCell", @"text":@"Today"},
                    @{@"type":@"CVFutureCell", @"text":@"Internship at Rheinfabrik, Düsseldorf", @"lines":[NSNumber numberWithInt:2], @"date":@"2014"},
                    @{@"type":@"CVStatusCell", @"text":@"Attend WWDC '14"},
                    @{@"type":@"CVFutureCell", @"text":@"Finish school with Abitur, study Computer Science", @"lines":[NSNumber numberWithInt:2], @"date":@"2015"},
                    @{@"type":@"CVFutureCell", @"text":@"Work at Apple :D", @"lines":[NSNumber numberWithInt:1], @"date":@"unknown"},
                    ];
    
    //Setup Detail Items
    NSString *codingString = @"I started coding when I was 12. The first programming language I learned was Visual Basic, since I still owned a Windows computer back then. But I noticed pretty fast that Visual Basic was not very intuitive, extensive or great in any other way. When I had to choose courses in school later that year, I chose to have computer science since I hoped that I'd learn something cool. But in school we only programmed in \"QBASIC\" (yeah right, BASIC, that old DOS thingy), that didn't even run on Windows itself. You had to run a program called \"DOS-Box\", an Emulator for Microsofts old MS-DOS operating system. That's why I basically ended up teaching myself via Tutorials and StackOverflow.\nAs of now, I can code in Objective-C, Java, C, VB (LOL), HTML/CSS/JS and shell. I'm also quite familiar with MySQL and SQLite Databases.";
    
    NSString *macString = @"I got my first Mac for Christmas in 2010. It was an iMac with a 21.5\" screen and I still love it. The screen looks absolutely amazing, even though it's not a \"Retina\" one.\nMy iMac is my first mac, but it's not the oldest Apple computer I own. My dad still had his old Apple IIc (see the image at the top) and gave it to me, but unfortunately, it doesn't work properly anymore. When you turn it on, random characters appear on the screen. I'll probably try to re-seat the chips in the next weeks, as I read somewhere that this is a common issue with Apple II's.\nApart from these two machines I also own an iPhone and an iPad and a Raspberry Pi, which is going to power my garage door opener soon so I can open my garage with my phone when I bike home from school.";
    
    NSString *firstAppString = @"Pong Reloaded was the first App that I've developed and although it was fairly simple, I'm still proud of it. I learned so much in such a short time and had so much fun while I was building it. The App got pulled by Atari in 2010, because they wanted to release their own App \"Atari's Greatest Hits\", which included Pong. They were nice to me and sent me a letter and a T-Shirt which you can see under \"Screenshots\".\n\n\n(Pull up for magic ✨)";
    
    NSString *internshipString = @"From the 14th of April to the 26th of April, I'll be interning at a local company in Düsseldorf called \"Rheinfabrik\". They create beautiful Apps for both iOS and Android. Their customers are very impressive too, as they've already worked with Mercedes-Benz, Deutsche Telekom and many more. You can view their previous projects and partners on their website:\nhttp://rheinfabrik.de/en";
    
    NSString *studyString = @"I currently go to the Sophie Scholl Gymnasium in Oberhausen and I expect to finish after my final exams next year. I'll have to write exams in Maths, Physics, History and English and then I'll finally get the \"Abitur\" degree, which will allow me to study at a University.\nHere is the website of my school:\nhttp://ssg-oberhausen.de\n\nI plan to study Computer Science, most likely at the University of Munich, and get a Master's degree. You can view the website of TUM here:\nhttps://www.tum.de/";
    
    NSString *appleString = @"After I finish University, my dream job would be to work at Apple on some great new products. When I'm over 18, I'll definitely apply for an internship at Apple.\nBut who knows what's going to happen in the next few years of my life?\nOr to say it with Steves words:\nStay hungry, stay foolish! 😉";
    
    _detailItems = @[
                     @"nil",
                     @{@"segue_type":@"pushToCVDetailViewController", @"title": @"Coding", @"image":@"Code", @"text":codingString},
                     @{@"segue_type":@"pushToCVDetailViewController", @"title": @"Apple", @"image":@"AppleIIc", @"text":macString},
                     @{@"segue_type":@"pushToProjectsFromCV", @"title": @"Pong Reloaded", @"icon":@"Pong App Icon", @"text":firstAppString, @"appstorebutton_text":@"Removed :(", @"appstorebutton_enabled":[NSNumber numberWithBool:NO], @"screenshotsbutton_enabled":[NSNumber numberWithBool:YES], @"screenshots_bundle":@"pong"},
                     @"nil",
                     @"nil",
                     @{@"segue_type":@"pushToCVDetailViewController", @"title": @"Internship", @"image":@"Rheinfabrik", @"text":internshipString},
                     @"nil",
                     @{@"segue_type":@"pushToCVDetailViewController", @"title": @"School", @"image":@"SSG", @"text":studyString},
                     @{@"segue_type":@"pushToCVDetailViewController", @"title": @"Job", @"image":@"Apple", @"text":appleString}
                     ];
    
    //Setup Table View
    [_tableView setBackgroundView:[[CVTableBackgroundView alloc] init]];
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
    [_tableView flashScrollIndicators];
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[CVDetailViewController class]]){
        NSDictionary *detailContents = [_detailItems objectAtIndex:_selectedIndex.row];
        CVDetailViewController *destination = (CVDetailViewController *)segue.destinationViewController;
        destination.text = [detailContents objectForKey:@"text"];
        destination.image = [UIImage imageNamed:[detailContents objectForKey:@"image"]];
        destination.title = [detailContents objectForKey:@"title"];
    }else if ([segue.destinationViewController isKindOfClass:[ProjectsDetailViewController class]]){
        NSDictionary *detailContents = [_detailItems objectAtIndex:_selectedIndex.row];
        ProjectsDetailViewController *destination = (ProjectsDetailViewController *)segue.destinationViewController;
        destination.textViewText = [detailContents objectForKey:@"text"];
        destination.title = [detailContents objectForKey:@"title"];
        if ([[detailContents objectForKey:@"title"] isEqualToString:@"Pong Reloaded"])
            destination.showsPongNeueButton = YES;
        destination.appIconImage = [UIImage imageNamed:[detailContents objectForKey:@"icon"]];
        if ([detailContents objectForKey:@"appstorebutton_text"])
            destination.appStoreButtonText = [detailContents objectForKey:@"appstorebutton_text"];
        destination.appStoreButtonEnabled = [[detailContents objectForKey:@"appstorebutton_enabled"] boolValue];
        destination.screenshotsButtonEnabled = [[detailContents objectForKey:@"screenshotsbutton_enabled"] boolValue];
    }
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//---------------------------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"CVPastCell"] || [[cellContents objectForKey:@"type"] isEqualToString:@"CVFutureCell"]){
        return [(NSNumber *)[cellContents objectForKey:@"lines"] floatValue] * 25.0f + 25.0f;
    }else if ([[cellContents objectForKey:@"type"] isEqualToString:@"CVStatusCell"]){
        return 44.0f;
    }
    
    return 44.0f; //default
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[_tableItems objectAtIndex:indexPath.row] objectForKey:@"type"]];
    
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"CVPastCell"] || [[cellContents objectForKey:@"type"] isEqualToString:@"CVFutureCell"]){
        UILabel *label = (UILabel *)[[cell.contentView viewWithTag:30] viewWithTag:20];
        label.text = [cellContents objectForKey:@"text"];
    }else if ([[cellContents objectForKey:@"type"] isEqualToString:@"CVStatusCell"]){
        UILabel *statusLabel = (UILabel *)[cell.contentView viewWithTag:30];
        statusLabel.text = [cellContents objectForKey:@"text"];
    }
    
    UIView *dotView = [cell.contentView viewWithTag:2];
    UIColor *backgroundColor;
    switch (indexPath.row) {
        case 0:
            backgroundColor = [UIColor colorWithRed:0.31 green:0.94 blue:0.46 alpha:1];
            break;
        case 1:
            backgroundColor = [UIColor colorWithRed:0.13 green:0.86 blue:0.65 alpha:1];
            break;
        case 2:
            backgroundColor = [UIColor colorWithRed:0.13 green:0.69 blue:0.88 alpha:1];
            break;
        case 3:
            backgroundColor = [UIColor colorWithRed:0.22 green:0.5 blue:0.96 alpha:1];
            break;
        case 4:
            backgroundColor = [UIColor colorWithRed:0.42 green:0.37 blue:0.93 alpha:1];
            break;
        case 5:
            backgroundColor = [UIColor colorWithRed:0.77 green:0.23 blue:0.66 alpha:1];
            break;
        case 6:
            backgroundColor = [UIColor colorWithRed:0.91 green:0.19 blue:0.5 alpha:1];
            break;
        case 7:
            backgroundColor = [UIColor colorWithRed:0.99 green:0.21 blue:0.39 alpha:1];
            break;
        case 8:
            backgroundColor = [UIColor colorWithRed:0.99 green:0.35 blue:0.35 alpha:1];
            break;
        case 9:
            backgroundColor = [UIColor colorWithRed:0.99 green:0.53 blue:0.3 alpha:1];
            break;
        default:
            backgroundColor = [dotView tintColor];
            break;
    }
    dotView.backgroundColor = backgroundColor;
    
    return cell;
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//---------------------------------------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"CVPastCell"] || [[cellContents objectForKey:@"type"] isEqualToString:@"CVFutureCell"]){
        UILabel *label = (UILabel *)[[cell.contentView viewWithTag:30] viewWithTag:20];
        UIView *bubbleView = (UIView *)[cell.contentView viewWithTag:30];
        UIImageView *arrowView = (UIImageView *)[[cell.contentView viewWithTag:30] viewWithTag:10];
        arrowView.image = [UIImage imageNamed:@"Detail Indicator White"];
        bubbleView.tintColor = [UIColor colorWithRed:0.11 green:0.49 blue:0.98 alpha:1];
        [bubbleView setNeedsDisplay];
        label.textColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"CVPastCell"] || [[cellContents objectForKey:@"type"] isEqualToString:@"CVFutureCell"]){
        UILabel *label = (UILabel *)[[cell.contentView viewWithTag:30] viewWithTag:20];
        UIView *bubbleView = (UIView *)[cell.contentView viewWithTag:30];
        UIImageView *arrowView = (UIImageView *)[[cell.contentView viewWithTag:30] viewWithTag:10];
        arrowView.image = [UIImage imageNamed:@"Detail Indicator"];
        bubbleView.tintColor = [UIColor whiteColor];
        [bubbleView setNeedsDisplay];
        label.textColor = [UIColor blackColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    if ([[cellContents objectForKey:@"type"] isEqualToString:@"CVPastCell"] || [[cellContents objectForKey:@"type"] isEqualToString:@"CVFutureCell"]){
        _selectedIndex = indexPath;
        NSDictionary *detailContents = [_detailItems objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:[detailContents objectForKey:@"segue_type"] sender:self];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end

//---------------------------------------------------------------------------------------------------------------