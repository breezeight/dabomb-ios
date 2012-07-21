//
//  MatchViewController.m
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import "MatchViewController.h"
#import "Match.h"

@interface MatchViewController ()

- (void)play;

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
    [self updateTimer:self.timer];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self play];
}

- (void)play {
    self.match.createdAt = [NSDate date];
    [self startTimer];
    [self updateTimer:self.timer];
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
