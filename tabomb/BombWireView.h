//
//  BombWireView.h
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BombWire;

@interface BombWireView : UIButton

- (void)updateWithWire:(BombWire *)wire;
@property (strong, nonatomic) BombWire *wire;

@end
