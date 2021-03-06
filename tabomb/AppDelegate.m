//
//  AppDelegate.m
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "PTPusherConnection.h"
#import "User.h"

@interface AppDelegate ()

- (User *)readUserFromDisk;

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize pusherClient = _pusherClient;
@synthesize user = _user;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //PUSHER
    self.pusherClient = [PTPusher pusherWithKey:PUSHER_API_KEY delegate:self encrypted:NO];
    
    // user
    self.user = [self readUserFromDisk];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.navigationController.navigationBarHidden = YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - 
#pragma mark PTPusherDelegate
/** Notifies the delegate that the PTPusher instance has connected to the Pusher service successfully.
 
 @param pusher The PTPusher instance that has connected.
 @param connection The connection for the pusher instance.
 */
- (void) pusher:(PTPusher *)pusher connectionDidConnect:(PTPusherConnection *)connection
{
    DLog(@"");
}


/** Notifies the delegate that the PTPusher instance has disconnected from the Pusher service.
 
 @param pusher The PTPusher instance that has connected.
 @param connection The connection for the pusher instance.
 @param error If the connection disconnected abnormally, error will be non-nil.
 */
- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection didDisconnectWithError:(NSError *)error
{
    DLog(@"%@", error);
    self.pusherClient.reconnectAutomatically = YES;
}

/** Notifies the delegate that the PTPusher instance failed to connect to the Pusher service.
 
 If reconnectAutomatically is YES, PTPusher will attempt to reconnect if the initial connection failed.
 
 This reconnect attempt will happen after this message is sent to the delegate, giving the delegate
 a chance to inspect the connection error and disable automatic reconnection if it thinks the reconnection
 attempt is likely to fail, depending on the error.
 
 @param pusher The PTPusher instance that has connected.
 @param connection The connection for the pusher instance.
 @param error The connection error.
 */
- (void)pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection failedWithError:(NSError *)error
{
    DLog(@"");
    self.pusherClient.reconnectAutomatically = YES;
}

/** Notifies the delegate that the PTPusher instance is about to attempt reconnection.
 
 You may wish to use this method to keep track of the number of reconnection attempts and abort after a fixed number.
 
 If you do not set the `reconnectAutomatically` property of the PTPusher instance to NO, it will continue attempting
 to reconnect until a successful connection has been established.
 
 @param pusher The PTPusher instance that has connected.
 @param connection The connection for the pusher instance.
 */
- (void)pusher:(PTPusher *)pusher connectionWillReconnect:(PTPusherConnection *)connection afterDelay:(NSTimeInterval)delay
{
    DLog(@"");
}

/** Notifies the delegate of the request that will be used to authorize access to a channel.
 
 When using the Pusher Javascript client, authorization typically relies on an existing session cookie
 on the server; when the Javascript client makes an AJAX POST to the server, the server can return
 the user's credentials based on their current session.
 
 When using libPusher, there will likely be no existing server-side session; authorization will
 need to happen by some other means (e.g. an authorization token or HTTP basic auth).
 
 By implementing this delegate method, you will be able to set any credentials as necessary by
 modifying the request as required (such as setting POST parameters or headers).
 */
- (void)pusher:(PTPusher *)pusher willAuthorizeChannelWithRequest:(NSMutableURLRequest *)request
{
    DLog(@"");
}

/** Notifies the delegate that the PTPusher instance has subscribed to the specified channel.
 
 This method will be called after any channel authorization has taken place and when a subscribe event has been received.
 
 @param pusher The PTPusher instance that has connected.
 @param channel The channel that was subscribed to.
 */
- (void)pusher:(PTPusher *)pusher didSubscribeToChannel:(PTPusherChannel *)channel
{
    //LOG
    DLog(@"");
}

/** Notifies the delegate that the PTPusher instance has unsubscribed from the specified channel.
 
 This method will be called immediately after unsubscribing from a channel.
 
 @param pusher The PTPusher instance that has connected.
 @param channel The channel that was unsubscribed from.
 */
- (void)pusher:(PTPusher *)pusher didUnsubscribeFromChannel:(PTPusherChannel *)channel
{
    DLog(@"");
}

/** Notifies the delegate that the PTPusher instance failed to subscribe to the specified channel.
 
 The most common reason for subscribing failing is authorization failing for private/presence channels.
 
 @param pusher The PTPusher instance that has connected.
 @param channel The channel that was subscribed to.
 @param error The error returned when attempting to subscribe.
 */
- (void)pusher:(PTPusher *)pusher didFailToSubscribeToChannel:(PTPusherChannel *)channel withError:(NSError *)error
{
    DLog(@"");
}

/** Notifies the delegate that an error event has been received.
 
 If a client is binding to all events, either through the client or using NSNotificationCentre, they will also
 receive notification of this event like any other.
 
 @param pusher The PTPusher instance that received the event.
 @param errorEvent The error event.
 */
- (void)pusher:(PTPusher *)pusher didReceiveErrorEvent:(PTPusherErrorEvent *)errorEvent
{
    DLog(@"");
}

#pragma mark User session

- (NSString *)userCacheFile {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"sharedUser.plist"];
}

- (User *)readUserFromDisk {
	// read from disk		
	if (![[NSFileManager defaultManager] fileExistsAtPath:[self userCacheFile]]) {
		return nil;
	}
	
	NSData *data = [[NSData alloc] initWithContentsOfFile:[self userCacheFile]]; 
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];	
	
	User *user = [unarchiver decodeObjectForKey:@"user"];
	[unarchiver finishDecoding];
    
	return user;
}

- (BOOL)saveUserToDisk:(User *)user {
	NSMutableData *data = [[NSMutableData alloc] init]; 
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	
	[archiver encodeObject:user forKey:@"user"];
	[archiver finishEncoding];
    
    // create user file
	BOOL result = [data writeToFile:[self userCacheFile] atomically:YES];
	if (result) {
		DLog(@"user was saved to disk: %@", user);
        self.user = user;
	} else {
		DLog(@"error while saving user to disk");
	}
	
	return result;
}

- (BOOL)removeUserFromDisk {
	// remove user file
	if ([[NSFileManager defaultManager] removeItemAtPath:[self userCacheFile] error:nil]) {
        self.user = nil;
        return YES;
    }
    return NO;
}

@end
