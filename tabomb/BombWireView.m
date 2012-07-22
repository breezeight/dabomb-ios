//
//  BombWireView.m
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import "BombWireView.h"
#import "BombWire.h"

@implementation BombWireView

@synthesize wire = _wire;

- (void)setup {
    [self addTarget:self action:@selector(cutWire) forControlEvents:UIControlEventTouchUpInside];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)updateWithWire:(BombWire *)wire {
    self.wire = wire;
    [self setTitle:wire.colorName forState:UIControlStateNormal];
    [self setTitleColor:wire.color forState:UIControlStateNormal];
    [self setTitleColor:wire.color forState:UIControlStateHighlighted];
    DLog(@"Button Color %@", wire.colorName);
    UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"btn_%@.png", wire.colorName]];
    [self setImage:btnImage forState:UIControlStateNormal];

    self.enabled = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)cutWire {
    self.enabled = NO;
    //self.backgroundColor = [UIColor darkGrayColor];
    UIImage *btnImage = [UIImage imageNamed:[NSString stringWithFormat:@"btn_red_cut.png", self.wire.colorName]];
    [self setImage:btnImage forState:UIControlStateDisabled];
    [self setAlpha:0.5];
}

@end
