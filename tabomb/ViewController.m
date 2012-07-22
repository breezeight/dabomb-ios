//
//  ViewController.m
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "MatchViewController.h"
#import "TBApi.h"
#import "User.h"
#import "Match.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (strong, nonatomic) MBProgressHUD *loadingView;

- (void)setCanPlay:(BOOL)canPlay;

- (BOOL)hasUser;
- (void)registerUser;
- (void)userRegistered:(User *)user;
- (void)failedToRegisterUserWithError:(NSString *)error;

- (void)createNewMatch;
- (void)matchCreated:(Match *)match;
- (void)failedToCreateMatchWithError:(NSString *)error;

@end

@implementation ViewController

@synthesize playButton = _playButton;
@synthesize loadingView = _loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"DaBomb";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.loadingView = nil;
    self.playButton = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.loadingView) {
        self.loadingView = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.loadingView];
    }
    
    if ([self hasUser]) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[TBApi sharedTBApi] connetToPusherChannel:delegate.user.username];
        [self setCanPlay:YES];
    } else {
        [self setCanPlay:NO];
        // register device
        [self registerUser];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    } else {
        return YES;
    }
}

- (void)setCanPlay:(BOOL)canPlay {
    self.playButton.hidden = !canPlay;
}

#pragma mark Actions

- (IBAction)play:(id)sender {
    // create match
    [self createNewMatch];
}

#pragma mark User

- (BOOL)hasUser {
    // check if there is a valid user session
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate.user != nil;
}

- (void)registerUser {
    self.loadingView.labelText = @"Loading…";
    [self.loadingView show:YES];
    
    // ask server to create new user
    [[TBApi sharedTBApi] initProfile:^(bool isOk, NSString *errorString, NSString* nickname) {
        if (isOk) {
            User *user = [[User alloc] init];
            user.username = nickname;
            [self userRegistered:user];
        } else {
            [self failedToRegisterUserWithError:errorString];
        }
    }];
}

- (void)userRegistered:(User *)user {
    // save user
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate saveUserToDisk:user];
    
    [self.loadingView hide:YES];
    // unlock play button
    [self setCanPlay:YES];
    
    [[TBApi sharedTBApi] connetToPusherChannel:user.username];
}

- (void)failedToRegisterUserWithError:(NSString *)error {
    [self.loadingView hide:YES];
    [[[UIAlertView alloc] initWithTitle:@"Cannot register user" 
                                message:error 
                               delegate:nil 
                      cancelButtonTitle:@"Ok" 
                      otherButtonTitles:nil] show];
}
#pragma mark pusher notification

- (void) onPlayerAvailable: (NSString*) matchCode
{
    DLog(@"match created");
    Match *match = [[Match alloc] init];
    match.identifier = matchCode;
    [self matchCreated:match];
}

- (void) didReceiveChannelEventNotification:(NSNotification *)notification
{
    DLog(@"DATA %@", [[[notification userInfo] objectForKey:@"PTPusherEventUserInfoKey"] data]);
    NSDictionary* data = [[[notification userInfo] objectForKey:@"PTPusherEventUserInfoKey"] data];
    if ([data objectForKey:@"code"])
        [self onPlayerAvailable:[data objectForKey:@"code"]];
    DLog(@"Starting the match");
    if ([data objectForKey:@"boom"]) {
        ULog(@"You smell like a cavaron... nobody want play with you!");
        [self.loadingView hide:YES];
    }
}


#pragma mark Match

- (void)createNewMatch {
    self.loadingView.labelText = @"Waiting for a player…";
    [self.loadingView show:YES];
    
    // ask server to create new match
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[TBApi sharedTBApi] playMatch:delegate.user.username 
                             block:^(bool isOk, NSString *errorString, bool isPlayerAvailable, NSString* matchCode) {
        if (isOk) {
            if (isPlayerAvailable) {
                DLog(@"match created");
                [self onPlayerAvailable:matchCode];
            } else {
                DLog(@"no players ready to play");
                // TODO: liste for player available notification.
                // call createNewMatch when ready
                [[NSNotificationCenter defaultCenter] 
                 addObserver:self 
                 selector:@selector(didReceiveChannelEventNotification:) 
                 name:PTPusherEventReceivedNotification 
                 object:[[TBApi sharedTBApi] channel]];
            }
        } else {
            [self failedToRegisterUserWithError:errorString];
        }
    }];
}

- (void)matchCreated:(Match *)match {
    [self.loadingView hide:YES];
    MatchViewController *matchViewController = [[MatchViewController alloc] initWithMatch:match];
    [self.navigationController pushViewController:matchViewController animated:YES];
}

- (void)failedToCreateMatchWithError:(NSString *)error {
    [self.loadingView hide:YES];
    [[[UIAlertView alloc] initWithTitle:@"Cannot create match" 
                                message:error 
                               delegate:nil 
                      cancelButtonTitle:@"Ok" 
                      otherButtonTitles:nil] show];
}

@end
