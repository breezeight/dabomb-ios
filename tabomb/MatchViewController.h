//
//  MatchViewController.h
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Match;
@class BombWireView;

@interface MatchViewController : UIViewController

- (id)initWithMatch:(Match *)match;
@property (strong, nonatomic) Match *match;

@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UIView *wiresView;

- (IBAction)wireViewPressed:(BombWireView *)view;

@end
