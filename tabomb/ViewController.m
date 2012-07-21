//
//  ViewController.m
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@property (strong, nonatomic) MBProgressHUD *loadingView;

- (void)setCanPlay:(BOOL)canPlay;

- (BOOL)hasUser;
- (void)registerUser;
- (void)userRegistered:(id)response;
- (void)failedToRegisterUserWithError:(NSError *)error;

- (void)createNewMatch;
- (void)matchCreated:(id)response;
- (void)failedToCreateMatchWithError:(NSError *)error;

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
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
    // TODO check if there is a valid user session
    return NO;
}

- (void)registerUser {
    self.loadingView.labelText = @"Loading…";
    [self.loadingView show:YES];
    
    // ask server to create new match
#warning registering a new user is simulated
    [self performSelector:@selector(userRegistered:) withObject:nil afterDelay:2];
}

- (void)userRegistered:(id)response {
    [self.loadingView hide:YES];
    // unlock play button
    [self setCanPlay:YES];
}

- (void)failedToRegisterUserWithError:(NSError *)error {
    [self.loadingView hide:YES];
    [[[UIAlertView alloc] initWithTitle:@"Cannot register user" 
                                message:[error localizedDescription] 
                               delegate:nil 
                      cancelButtonTitle:@"Ok" 
                      otherButtonTitles:nil] show];
}

#pragma mark Match

- (void)createNewMatch {
    self.loadingView.labelText = @"Waiting for a player…";
    [self.loadingView show:YES];
    
    // ask server to create new match
#warning creating a new match is simulated
    [self performSelector:@selector(matchCreated:) withObject:nil afterDelay:2];
}

- (void)matchCreated:(id)response {
    [self.loadingView hide:YES];
    [[[UIAlertView alloc] initWithTitle:@"Match created" 
                                message:nil 
                               delegate:nil 
                      cancelButtonTitle:@"Ok" 
                      otherButtonTitles:nil] show];
}

- (void)failedToCreateMatchWithError:(NSError *)error {
    [self.loadingView hide:YES];
    [[[UIAlertView alloc] initWithTitle:@"Cannot create match" 
                                message:[error localizedDescription] 
                               delegate:nil 
                      cancelButtonTitle:@"Ok" 
                      otherButtonTitles:nil] show];
}

@end
