//
//  LookText.h
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LookText : UIViewController {
    
    UILabel *lLableTime;
    UITextField *lTitle;
    UITextView *lContent;
    
    UITableView *lookTableView;
}
@property (nonatomic, retain) IBOutlet UILabel *lLableTime;
@property (nonatomic, retain) IBOutlet UITextField *lTitle;
@property (nonatomic, retain) IBOutlet UITextView *lContent;
- (IBAction)deleteText:(id)sender;
- (IBAction)saveText:(id)sender;

@property (nonatomic,retain) IBOutlet UITableView *lookTableView;

@end
