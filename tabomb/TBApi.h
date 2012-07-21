//
//  TBApi.h
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface TBApi : AFHTTPClient

+ (TBApi *)sharedTBApi;

- (void) initProfile:(void (^)(bool isOk, NSString *errorString, NSString* nickname))block;
- (void) playMatch:(NSString*)username block:(void (^)(bool isOk, NSString *errorString, bool isPlayerAvailable, NSString* matchCode))block;
- (void) onMatchFinished:(NSString*)username defuseTime:(NSNumber*)defuseTime block:(void (^)(bool isOk, NSString *errorString))block;

- (void) connetToPusherChannel:(NSString*)username;



//- (void) updateProfile:(NSString*)nickname block:(void (^)(bool *isOk, NSString *errorString))block;

@end
