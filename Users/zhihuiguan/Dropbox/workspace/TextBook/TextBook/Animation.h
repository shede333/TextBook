//
//  Animation.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-1.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Animation : UIViewController{
    NSString *test;
}

@property (retain ,nonatomic) NSString *test;

@property (retain, nonatomic) IBOutlet UIImageView *swSmile;


- (IBAction)startAnimation:(id)sender;
- (IBAction)endAnimation:(id)sender;


@end
