//
//  SWAccelerometer.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-30.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <math.h>

@interface SWAccelerometer : UIViewController<UIAccelerometerDelegate>{
    UIAccelerometer *accelerometer;
    UIImageView *contentView;
    UIImageView *compassView;
    float angleOld;
    float angleNew;
}

@property (nonatomic, retain) UIAccelerometer *accelerometer;
@property (nonatomic, retain) UIImageView *contentView;
@property (nonatomic, retain) UIImageView *compassView;

@end
