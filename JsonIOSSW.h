//
//  JsonIOSSW.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-8.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsonIOSSW : UIViewController<UITextViewDelegate>


@property (retain, nonatomic) IBOutlet UITextView *outShowTextView;

- (void)show;
- (IBAction)actionGet:(id)sender;

@end
