//
//  TBApi.m
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBApi.h"

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

- (void) initProfile:(void (^)(bool isOk, NSString *errorString, NSString* nickname))block
{
    [[TBApi sharedTBApi] postPath:kTBPlayerPath 
                      parameters:nil
                         success:^(AFHTTPRequestOperation *operation, id JSON) {
                             block(true, @"", @"TODO parse the response");
                         } 
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             block(false, @"TODO READ form server", @"");
                         }];
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
