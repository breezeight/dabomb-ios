//
//  TBApi.m
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBApi.h"
#import "AFJSONRequestOperation.h"
#import "AppDelegate.h"

@implementation TBApi

+ (TBApi *)sharedTBApi {
    static TBApi *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //TEST _sharedClient = [[AFGoWarAPIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://search.twitter.com/"]];
        _sharedClient = [[TBApi alloc] initWithBaseURL:[NSURL URLWithString:kTBAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

- (void) initProfile:(void (^)(bool isOk, NSString *errorString, NSString* nickname))block
{
    [[TBApi sharedTBApi] postPath:kTBPlayerPath 
                      parameters:nil
                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                             block(true, @"", [JSON objectForKey:@"username"]);
                         } 
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             block(false, @"TODO READ NETWORK ERROR form server", @"");
                             DLog(@"ERROR %@", error);
                         }];
}

- (void) playMatch:(NSString*)username block:(void (^)(bool isOk, NSString *errorString, bool isPlayerAvailable, NSString* matchCode))block
{
    
    [[TBApi sharedTBApi] postPath:[NSString stringWithFormat:kTBPlayPath, username] 
                       parameters:nil
                          success:^(AFHTTPRequestOperation *operation, id JSON) {
                              if ([[JSON objectForKey:@"code"] isKindOfClass:[NSNull class]]) { //No Players available
                                  block(true, @"No Player Available", false, @"null");
                              } else {
                                  block(true, @"", true, [JSON objectForKey:@"code"]);                                 
                              }
                          } 
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              block(false, @"TODO READ NETWORK ERROR form server", false, @"");
                              DLog(@"ERROR %@", error);
                          }];
}

- (void) onMatchFinished:(NSString*)username defuseTime:(NSNumber*)defuseTime block:(void (^)(bool isOk, NSString *errorString))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: defuseTime, @"defuseTime", nil];
    [[TBApi sharedTBApi] putPath:[NSString stringWithFormat:kTBScorePath, username] 
                      parameters:params 
                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                             block(true, @"");
                         } 
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             block(false, @"TODO READ form server");
                             DLog(@"ERROR %@", error);
    }];
}


- (void) connetToPusherChannel:(NSString*)username
{
    AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString * channelName = [NSString stringWithFormat:@"dabomb-%@",username];
    PTPusherChannel *channel = [appDelegate.pusherClient subscribeToChannelNamed:channelName];
}



/*
- (void) putProfile:(NSString*)nickname block:(void (^)(bool *isOk, NSString *errorString))block
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: nickname, @"nickname", nil];
    [[TBApi sharedTBApi] putPath:kTBProfilePath 
        parameters:params 
        success:^(AFHTTPRequestOperation *operation, id JSON) {
            block(true, @"");
        } 
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block(false, @"TODO READ form server");
        }];

}*/

@end
