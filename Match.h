//
//  Match.h
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BombWire.h"

#define kNumberOfWires 8

@interface Match : NSObject
{
    NSMutableArray *_wires;
}

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSArray *wires;
@property (strong, nonatomic) BombWire *killerWire;
- (void)shuffleWires;
- (BOOL)hasMoreWiresToCut;

@end
