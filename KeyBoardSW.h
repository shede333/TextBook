//
//  KeyBoardSW.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-28.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//



@interface KeyBoardSW : UIViewController



@property (retain, nonatomic) IBOutlet UITextField *inputTextField;
@property (retain, nonatomic) UIImageView *imageInputView;
@property (retain, nonatomic) IBOutlet UIImageView *tabbarView;

- (IBAction)actionNormal:(id)sender;
- (IBAction)actionSimple:(id)sender;
- (IBAction)actionScaleImage:(id)sender;



@end
