//
//  Match.m
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import "Match.h"

@interface Match ()

- (NSArray *)createWires;

@end

@implementation Match

@synthesize identifier = _identifier;
@synthesize createdAt = _createdAt;
@synthesize wires = _wires;
@synthesize killerWire = _killerWire;

- (id)init
{
    self = [super init];
    if (self) {
        self.wires = [self createWires];
    }
    return self;
}

- (NSMutableArray *)createWires {
    NSMutableArray *wires = [NSMutableArray arrayWithCapacity:kNumberOfWires];
    BombWire *wire;
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor redColor];
    wire.colorName = @"red";
    [wires addObject:wire];
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor greenColor];
    wire.colorName = @"green";
    [wires addObject:wire];
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor blueColor];
    wire.colorName = @"blue";
    [wires addObject:wire];
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor yellowColor];
    wire.colorName = @"yellow";
    [wires addObject:wire];
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor orangeColor];
    wire.colorName = @"orange";
    [wires addObject:wire];
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor purpleColor];
    wire.colorName = @"purple";
    [wires addObject:wire];
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor magentaColor];
    wire.colorName = @"magenta";
    [wires addObject:wire];
    
    wire = [[BombWire alloc] init];
    wire.color = [UIColor cyanColor];
    wire.colorName = @"cyan";
    [wires addObject:wire];
    
    return wires;
}

- (void)shuffleWires {
    srandom(time(NULL));
    for (NSUInteger i = [_wires count] - 1; i > 0; i--) {
        [_wires exchangeObjectAtIndex:i withObjectAtIndex:random() % (i + 1)];
    }
    
    for (BombWire *wire in self.wires) {
        wire.cut = NO;
    }
    
    BombWire *wire = [self.wires objectAtIndex:random() % self.wires.count];
    self.killerWire = wire;
}

@end
