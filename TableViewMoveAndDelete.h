//
//  TableViewMoveAndDelete.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-5-9.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    cellStatusOfNormal,
    cellStatusOfEdit,
    cellStatusOfDelete,
}cellStatus;

@interface TableViewMoveAndDelete : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *arrOfDataSource;
    int myCellOfStatus;
}

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UILabel *lableOfStatus;


- (IBAction)actionMove:(id)sender;
- (IBAction)actionDelete:(id)sender;
- (IBAction)actionFinish:(id)sender;

@end
