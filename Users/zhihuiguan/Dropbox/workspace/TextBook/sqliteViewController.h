//
//  sqliteViewController.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-9.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface sqliteViewController : UIViewController<UITextFieldDelegate>







@property (retain, nonatomic) IBOutlet UITextView *inputTextField;
@property (retain, nonatomic) IBOutlet UITextView *lableShow;




- (IBAction)actionDo:(id)sender;

+ (sqlite3 *)getDB;

@end
