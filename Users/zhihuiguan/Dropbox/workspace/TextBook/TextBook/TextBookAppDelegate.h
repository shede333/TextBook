//
//  TextBookAppDelegate.h
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextBookViewController;

@interface TextBookAppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController *nc ;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *nc;
@property (nonatomic, retain) IBOutlet TextBookViewController *viewController;





- (void)DuplicateDB;



@end
