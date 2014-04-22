//
//  ProjectsViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 10.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "ProjectsViewController.h"

//---------------------------------------------------------------------------------------------------------------

@interface ProjectsViewController ()

@property (nonatomic, strong) NSArray *tableItems;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

//---------------------------------------------------------------------------------------------------------------

@implementation ProjectsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Setup tableItems
    _tableItems = @[
                    @{@"id":@"pong", @"title":@"Pong Reloaded", @"subtitle":@"A clone of the first and most famous video game of all time, \"Pong\" by Atari.", @"image":[UIImage imageNamed:@"Pong Table Background"]},
                    @{@"id":@"sophiealpha", @"title":@"sophie.alpha", @"subtitle":@"A website for my school where students can collaborate online, view their schedule and much more.", @"image":[UIImage imageNamed:@"sophiealpha Table Background"]},
                    @{@"id":@"euro2012", @"title":@"UEFA EURO 2012", @"subtitle":@"An unofficial betting website I made for my family and friends.", @"image":[UIImage imageNamed:@"EURO 2012 Table Background"]},
                    @{@"id":@"poque", @"title":@"Poque", @"subtitle":@"A card game based on an old game my grandparents taught me when I was a kid.", @"image":[UIImage imageNamed:@"Poque Table Background"]},
                    @{@"id":@"jukebox", @"title":@"Jukebox", @"subtitle":@"A music app which is controlled by other devices in the network.", @"image":[UIImage imageNamed:@"Jukebox Table Background"]},
                    @{@"id":@"klock", @"title":@"Klock", @"subtitle":@"A simple yet elegant clock application.", @"image":[UIImage imageNamed:@"Klock Table Background"]}];
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
    if (_selectedIndexPath){
        UIView *highlightView = [[_tableView cellForRowAtIndexPath:_selectedIndexPath].contentView viewWithTag:50];
        [UIView animateWithDuration:0.1f animations:^{
            highlightView.alpha = 0.0f;
        }];
    }
    [_tableView flashScrollIndicators];
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[ProjectsDetailViewController class]]){
        NSDictionary *cellContents = [_tableItems objectAtIndex:_selectedIndexPath.row];
        ProjectsDetailViewController *destination = (ProjectsDetailViewController *)segue.destinationViewController;
        destination.title = [cellContents objectForKey:@"title"];
        if ([[cellContents objectForKey:@"id"] isEqualToString:@"pong"]){
            destination.appIconImage = [UIImage imageNamed:@"Pong App Icon"];
            destination.textViewText = @"Pong Reloaded was the first App that I've developed and although it was fairly simple, I'm still proud of it. I learned so much in such a short time and had so much fun while I was building it. The App got pulled by Atari in 2010, because they wanted to release their own App called \"Atari's Greatest Hits\" which included Pong. At least they were nice to me and sent me a letter and a T-Shirt which you can see under \"Screenshots\".\n\n\n(Pull up for magic ✨)";
            destination.appStoreButtonEnabled = NO; //:(
            destination.screenshotsButtonEnabled = YES;
            destination.appStoreButtonText = @"Removed :(";
            destination.screenshotsBundleName = @"pong";
            destination.showsPongNeueButton = YES; //HELLYEAH!!! :)
        }else if ([[cellContents objectForKey:@"id"] isEqualToString:@"sophiealpha"]){
            destination.appIconImage = [UIImage imageNamed:@"sophie alpha Icon"];
            destination.textViewText = @"sophie.alpha is an online platform for students of the Sophie-Scholl-Gymnasium in Oberhausen. Users are able to ask, answer and upvote/downvote questions (similar to StackOverflow/StackExchange), view their schedule, discuss their homework and view their marks. sophie.alpha is still far away from a stable 1.0 release, so I decided not to release it yet. I definitely want to release it before I finish school next year though.";
            destination.appStoreButtonEnabled = NO;
            destination.appStoreButtonText = @"WIP"; //WorkInProgress
            destination.screenshotsButtonEnabled = YES;
            destination.screenshotsBundleName = @"sophiealpha";
        }else if ([[cellContents objectForKey:@"id"] isEqualToString:@"euro2012"]){
            destination.appIconImage = [UIImage imageNamed:@"Euro 2012 Icon"];
            destination.textViewText = @"This was a betting website I made for the UEFA EURO 2012, a big football championship in Europe. Many friends of mine betted with me and it was very fun. I plan to setup such a website again for the FIFA Worldcup 2014 held in Brazil this summer and maybe I'll make an App for that, too. This project was built with Java Enterprise Edition and ran on a JBoss Application Server.";
            destination.appStoreButtonEnabled = NO;
            destination.appStoreButtonText = @"No App";
            destination.screenshotsButtonEnabled = YES;
            destination.screenshotsBundleName = @"euro2012";
        }else if ([[cellContents objectForKey:@"id"] isEqualToString:@"poque"]){
            destination.appIconImage = [UIImage imageNamed:@"Poque Icon"];
            destination.textViewText = @"Poque is a card game which is like an easier version of poker. The German name is \"Poch\" but I decided to call it \"Poque\" since it sounds better and the game is originally from France. \"Poch\" is very old and there are no universal rules (at least I found none on the web) and that's why I decided to revive this game.\nThere are only two screenshots of this game because it is still at a very early stage of development.";
            destination.appStoreButtonEnabled = NO;
            destination.appStoreButtonText = @"WIP"; //WorkInProgress
            destination.screenshotsButtonEnabled = YES;
            destination.screenshotsBundleName = @"poque";
        }else if ([[cellContents objectForKey:@"id"] isEqualToString:@"jukebox"]){
            destination.appIconImage = [UIImage imageNamed:@"Jukebox Icon"];
            destination.textViewText = @"When I got my new iPhone last year, I needed a purpose for my old one. So I decided to buy a dock and connect it to my stereo. The sound was great, but I wanted a way to remotely control my music from my desk while I work. That was the moment I started working on Jukebox. Basically, Jukebox consists of 2 Apps: The Player and the Remote Control.\nAt the moment, Jukebox only supports music from the streaming service Spotify, but I plan to add rdio and the phones music library as well.\nPS: Sorry for the long video loading time. The video file is pretty big, but at least in a good quality 😄.";
            destination.appStoreButtonEnabled = YES;
            destination.appStoreButtonText = @"Play video"; //WorkInProgress
            destination.screenshotsButtonEnabled = YES;
            destination.isVideoURL = YES;
            destination.appStoreURL = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/6633338/IMG_0036.MOV"];
            destination.screenshotsBundleName = @"jukebox";
        }else if ([[cellContents objectForKey:@"id"] isEqualToString:@"klock"]){
            destination.appIconImage = [UIImage imageNamed:@"Klock Icon"];
            destination.textViewText = @"Klock is a very simple clock application I built when my wall clock died. It looks simple and beautiful, and thats all I needed. There is an option to choose between various colors though.";
            destination.appStoreButtonEnabled = YES;
            destination.screenshotsButtonEnabled = YES;
            destination.screenshotsBundleName = @"klock";
        }
    }
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource
//---------------------------------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectsCell"];
    
    NSDictionary *cellContents = [_tableItems objectAtIndex:indexPath.row];
    UIImageView *backgroundImageView = (UIImageView *)[cell.contentView viewWithTag:10];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:30];
    UILabel *subtitleLabel = (UILabel *)[cell.contentView viewWithTag:40];
    
    //Setup Background Image View
    backgroundImageView.image = [[cellContents objectForKey:@"image"] blurredImageWithRadius:4.0f iterations:3 tintColor:[UIColor blackColor]];
    
    //Setup Title Label
    titleLabel.text = [cellContents objectForKey:@"title"];
    
    //Setup Subtitle Label
    subtitleLabel.text = [cellContents objectForKey:@"subtitle"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate
//---------------------------------------------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *highlightView = [[tableView cellForRowAtIndexPath:indexPath].contentView viewWithTag:50];
    [UIView animateWithDuration:0.1f animations:^{
        highlightView.alpha = 0.3f;
    }];
    _selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"pushToDetailViewController" sender:self];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *highlightView = [[tableView cellForRowAtIndexPath:indexPath].contentView viewWithTag:50];
    [UIView animateWithDuration:0.1f animations:^{
        highlightView.alpha = 0.3f;
    }];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *highlightView = [[tableView cellForRowAtIndexPath:indexPath].contentView viewWithTag:50];
    [UIView animateWithDuration:0.1f animations:^{
        highlightView.alpha = 0.0f;
    }];
}

@end

//---------------------------------------------------------------------------------------------------------------