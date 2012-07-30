//
//  CopyTableViewCell.h
//  TextBook
//
//  Created by shaowei on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopyTableViewCell : UITableViewCell{
    id delegate;
}
@property (nonatomic, retain) id delegate;

@end
