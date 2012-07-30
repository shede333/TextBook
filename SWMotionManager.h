//
//  SWMotionManager.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-31.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface SWMotionManager : UIViewController{
    CMMotionManager *motionManager;
}

@property (nonatomic,retain) CMMotionManager *motionManager;

@property (retain, nonatomic) IBOutlet UILabel *accX;
@property (retain, nonatomic) IBOutlet UILabel *accY;
@property (retain, nonatomic) IBOutlet UILabel *accZ;

@property (retain, nonatomic) IBOutlet UILabel *gyX;
@property (retain, nonatomic) IBOutlet UILabel *gyY;
@property (retain, nonatomic) IBOutlet UILabel *gyZ;

@property (retain, nonatomic) IBOutlet UILabel *magX;
@property (retain, nonatomic) IBOutlet UILabel *magY;
@property (retain, nonatomic) IBOutlet UILabel *magZ;


- (IBAction)startAccelerometer:(id)sender;
- (IBAction)stopAccelerometer:(id)sender;
- (IBAction)startGyroscope:(id)sender;
- (IBAction)stopGyroscope:(id)sender;
- (IBAction)startMagnetometer:(id)sender;
- (IBAction)stopMagnetometer:(id)sender;

@end
