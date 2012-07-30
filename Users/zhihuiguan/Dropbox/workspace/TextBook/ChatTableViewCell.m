//
//  ChatTableViewCell.m
//  FreeTalk
//
//  Created by  on 11-12-7.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell
@synthesize imageViewOthers;
@synthesize imageViewMine;
@synthesize imageOtherBorder;
@synthesize imageMineBorder;
@synthesize imageContentMine;
@synthesize imageContentFriend;
@synthesize lableOthersNick;
@synthesize lableNickMine;
@synthesize lableChatContentOthers;
@synthesize lableChatContentMine;
@synthesize lableChatTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    NSLog(@"cell的自定义hm被触摸了\n");
    // Configure the view for the selected state
}

- (void)dealloc {
    [imageViewOthers release];
    [imageViewMine release];
    [lableOthersNick release];
    [lableNickMine release];
    [lableChatContentOthers release];
    [lableChatContentMine release];
    [lableChatTime release];
    [imageOtherBorder release];
    [imageMineBorder release];
    [imageContentMine release];
    [imageContentFriend release];
    [super dealloc];
}
@end
