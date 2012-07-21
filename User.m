//
//  User.m
//  tabomb
//
//  Created by Nebil Kriedi on 21/07/12.
//  Copyright (c) 2012 5Knot. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username = _username;

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.username forKey:@"username"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        self.username = [decoder decodeObjectForKey:@"username"];
    }
	return self;
}

@end
