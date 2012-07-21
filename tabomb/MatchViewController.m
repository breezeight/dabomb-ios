//
//  MatchViewController.m
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import "MatchViewController.h"
#import "Match.h"
#import "BombWireView.h"

@interface MatchViewController () <UIAlertViewDelegate>

- (void)updateWiresView;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDateFormatter *timerFormatter;
- (void)startTimer;
- (void)stopTimer;
- (void)updateTimer:(NSTimer *)timer;

@end

@implementation MatchViewController

@synthesize match = _match;
@synthesize timerLabel = _timerLabel;
@synthesize timer = _timer;
@synthesize timerFormatter = _timerFormatter;
@synthesize wiresView = _wiresView;

- (id)initWithMatch:(Match *)match
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.match = match;
        
        self.timerFormatter = [[NSDateFormatter alloc] init];
        self.timerFormatter.dateFormat = @"mm:ss";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.timerLabel = nil;
    self.wiresView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // update zero-timer
    [self updateTimer:self.timer];
    
    // shuffle match wires and update views
    [self.match shuffleWires];
    [self updateWiresView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // set creation date as the moment this controller appears
    self.match.createdAt = [NSDate date];
    // start timer
    [self startTimer];
    [self updateTimer:self.timer];
}

- (void)updateWiresView {
    for (BombWire *wire in self.match.wires) {
        BombWireView *view = [self.wiresView.subviews objectAtIndex:[self.match.wires indexOfObject:wire]];
        [view updateWithWire:wire];
    }
}

- (IBAction)wireViewPressed:(BombWireView *)view {
    // cut this wire!
    BombWire *wire = view.wire;
    wire.cut = YES;
    
    // check if user has pressed the killer wire
    // or if user has cut all the good wires
    if ([self.match.killerWire isEqual:wire]) {
        [self stopTimer];
        [[[UIAlertView alloc] initWithTitle:@"You looooose!" 
                                    message:nil 
                                   delegate:self 
                          cancelButtonTitle:@"Close" 
                          otherButtonTitles:@"Play again", nil] show];
    } else if (![self.match hasMoreWiresToCut]) {
        [self stopTimer];
        [[[UIAlertView alloc] initWithTitle:@"You wiiin!" 
                                    message:nil 
                                   delegate:self 
                          cancelButtonTitle:@"Close" 
                          otherButtonTitles:@"Play again", nil] show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([self.match hasMoreWiresToCut]) {
#warning start a new match is simulated
        self.match.createdAt = [NSDate date];
        [self.match shuffleWires];
        [self updateWiresView];
        [self startTimer];
    }
}

#pragma mark Timer

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 
                                                  target:self 
                                                selector:@selector(updateTimer:) 
                                                userInfo:nil 
                                                 repeats:YES];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTimer:(NSTimer *)timer {
    NSDate *relativeDate;
    NSTimeInterval elapsedTime = - [self.match.createdAt timeIntervalSinceNow];
    relativeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
    self.timerLabel.text = [self.timerFormatter stringFromDate:relativeDate];
}

@end
