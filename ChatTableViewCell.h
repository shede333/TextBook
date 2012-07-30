//
//  ChatTableViewCell.h
//  FreeTalk
//
//  Created by  on 11-12-7.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell



@property (retain, nonatomic) IBOutlet UIImageView *imageViewOthers;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewMine;
@property (retain, nonatomic) IBOutlet UIImageView *imageOtherBorder;
@property (retain, nonatomic) IBOutlet UIImageView *imageMineBorder;
@property (retain, nonatomic) IBOutlet UIImageView *imageContentMine;
@property (retain, nonatomic) IBOutlet UIImageView *imageContentFriend;

@property (retain, nonatomic) IBOutlet UILabel *lableOthersNick;
@property (retain, nonatomic) IBOutlet UILabel *lableNickMine;
@property (retain, nonatomic) IBOutlet UILabel *lableChatContentOthers;
@property (retain, nonatomic) IBOutlet UILabel *lableChatContentMine;
@property (retain, nonatomic) IBOutlet UILabel *lableChatTime;

@end
