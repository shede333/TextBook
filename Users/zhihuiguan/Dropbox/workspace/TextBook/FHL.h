//
//  FHL.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-11-22.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FHL : UIView{
    UIActivityIndicatorView *dfhl;
    CATextLayer *label;
    CALayer *subLayer;
}

- (id)initWithFrame:(CGRect)frame andTextString:(NSString *)textString;

@end
