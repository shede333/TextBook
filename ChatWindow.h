//
//  chatWindow.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-15.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface ChatWindow : UIViewController<UITableViewDelegate,UITableViewDataSource,HPGrowingTextViewDelegate>{
    HPGrowingTextView *textInput;
    NSTimeInterval          animationDuration;  
    UIViewAnimationCurve    animationCurve;
    CGFloat                 keyboardHeight; //键盘高度
    CGPoint                 tableViewOffset;  // 暂时无用
//    float                   imageBottomInputOriginHeight;
    
    NSMutableArray *arrTableView;
    
    BOOL isFaceFlag;
    UIScrollView *faceScroll;
    
}

@property (nonatomic,retain) HPGrowingTextView *textInput;
@property (retain, nonatomic) IBOutlet UIView *imageBottom;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIImageView *imageBottomInput;
@property (retain, nonatomic) NSMutableArray *arrTableView;



- (void)slideFrame:(BOOL)up curve:(UIViewAnimationCurve)curve duration:(NSTimeInterval)duration face:(BOOL)isFaceBtn;
- (void)moveTableviewToEnd;
- (IBAction)actionFace:(id)sender;
- (IBAction)actionSend:(id)sender;

@end
