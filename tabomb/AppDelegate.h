//
//  AppDelegate.h
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTPusher.h"
@class User;

@interface AppDelegate : UIResponder <UIApplicationDelegate, PTPusherDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) PTPusher *pusherClient;

@property (strong, nonatomic) User *user;
- (BOOL)saveUserToDisk:(User *)user;

@end
