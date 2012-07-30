//
//  SubHitTestView2.m
//  TextBook
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubHitTestView2.h"

@implementation SubHitTestView2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"SW3- position x:%f,y:%f",point.x,point.y);
//    if (point.x < 50 && point.y < 50) {
//        return NO;
//    }else if(){
//        return YES;
//    }
    return [super pointInside:point withEvent:event];
  
}

@end
