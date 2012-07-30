//
//  TextBookViewController.h
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIBadgeView.h"
#import "FHL.h"
#import "SWAccelerometer.h"
#import <math.h>

@interface TextBookViewController : UIViewController <MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate> {
    NSMutableDictionary *wdictionary;

    UITableView *wTableView;
    MBProgressHUD *HUD;
    NSTimer *timerTest;
    UIBadgeView *badgeView_;
    UIAlertView *av;
    int avInt;
    FHL *fhl;
}
- (IBAction)newText:(id)sender;
@property (nonatomic, retain) IBOutlet UITableView *wTableView;
- (void)timerTestAction;
- (IBAction)timerStart:(id)sender;
- (IBAction)timerStop:(id)sender;
- (IBAction)switchChange:(id)sender;
- (void)tt;
- (void)setBadgeNumber:(NSUInteger)number;
- (void)searchFile;
- (IBAction)alertTest;
- (void) pLIst;
- (void)rangeTest;
- (void)test;

@end
