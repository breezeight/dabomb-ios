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
    self.enabled = YES;
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)cutWire {
    self.enabled = NO;
    self.backgroundColor = [UIColor darkGrayColor];
}

@end
