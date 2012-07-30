//
//  CopyPasteTextController.h
//  TextBook
//
//  Created by shaowei on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface CopyPasteTextController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    //用来标识是否显示快捷菜单
    BOOL menuVisible;
    UITableView *tableView;
}

@property (nonatomic, getter=isMenuVisible) BOOL menuVisible;
@property (retain, nonatomic) IBOutlet UITextView *showTextView;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end 
