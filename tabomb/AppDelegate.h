//
//  AppDelegate.h
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTPusher.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, PTPusherDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) PTPusher *pusherClient;

@end
