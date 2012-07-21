//
//  BombWire.h
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BombWire : NSObject

@property (strong, nonatomic) NSString *colorName;
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) BOOL cut;

@end
