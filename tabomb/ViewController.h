//
//  ViewController.h
//  tabomb
//
//  Created by nicolabrisotto on 21/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// this is the main view controller
// here the device is registered to the server
// and user can start the first match

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)play:(id)sender;

@end
