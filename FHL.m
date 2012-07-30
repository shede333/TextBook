//
//  FHL.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-11-22.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "FHL.h"


@implementation FHL


- (id)initWithFrame:(CGRect)frame andTextString:(NSString *)textString
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        if (textString) {
            
            CGSize size = [textString sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0f]
                          constrainedToSize:CGSizeMake(200.0f, 100.0f)
                              lineBreakMode:UILineBreakModeHeadTruncation];
            //添加-黑框层
            subLayer = [CALayer layer];
            subLayer.backgroundColor = [UIColor blackColor].CGColor;
            subLayer.opacity = 0.8f;
            subLayer.cornerRadius = 10;
            CGRect frame = self.frame;
            subLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
            subLayer.frame = CGRectMake(frame.size.width/2,
                                         frame.size.height/2,
                                         80 + size.width,
                                         80 + size.height);
            //        subLayer.anchorPoint = CGPointMake(0.0f, 0.0f);
            subLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
            NSLog(@"ww:%f,hh:%f\n",subLayer.frame.origin.x,subLayer.frame.origin.y);
            [self.layer addSublayer:subLayer];
            
            
            
            //添加-风火轮
            dfhl = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            dfhl.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);  
            dfhl.center = CGPointMake(subLayer.position.x, subLayer.position.y+subLayer.frame.size.height/2 - 40);
            NSLog(@"wwww:%f,hh:%f\n",subLayer.frame.origin.x,subLayer.frame.origin.y);
            [self addSubview:dfhl];
            [dfhl startAnimating]; 
            
            
            
            
            
            CGRect validFrame = CGRectMake(subLayer.frame.size.width/2, size.height/2+5.0f, size.width, size.height);
            //添加-文字层
            label = [[CATextLayer alloc] init];
            [label setAnchorPoint:CGPointMake(0.5f, 0.0f)];
            [label setFont:@"Helvetica-Bold"];
            [label setFontSize:20];  
            [label setFrame:validFrame];
            [label setPosition:CGPointMake(subLayer.frame.size.width/2, 10.0f)];
            [label setString:textString];
            [label setWrapped:YES];
            [label setTruncationMode:kCATruncationEnd];
            [label setAlignmentMode:kCAAlignmentCenter];
            [label setForegroundColor:[[UIColor whiteColor] CGColor]];
            [subLayer addSublayer:label];
            
        }else{
            //添加-黑框层
            subLayer = [CALayer layer];
            subLayer.backgroundColor = [UIColor blackColor].CGColor;
            subLayer.opacity = 0.8f;
            subLayer.cornerRadius = 10;
            CGRect frame = self.frame;
            subLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
            subLayer.bounds = CGRectMake(frame.size.width/2, frame.size.height/2, 80, 80);
            //        subLayer.anchorPoint = CGPointMake(0.0f, 0.0f);
            subLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
//            NSLog(@"ww:%f,hh:%f\n",frame.size.width/2, frame.size.height/2);
            [self.layer addSublayer:subLayer];
            
            //添加-风火轮
            dfhl = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            dfhl.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);  
            dfhl.center = subLayer.position;
            [self addSubview:dfhl];
            [dfhl startAnimating]; 
        }
        
        
        
        
        

        
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

- (void)dealloc{
    [label release];
    [dfhl release];
    [super dealloc];
}

@end
