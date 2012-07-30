//
//  NewText.h
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewText : UIViewController <UITextViewDelegate>{
    
    UIDatePicker *dataPicker;
    UILabel *lableDate;
    UITextView *textContent;
    UITextField *titleText;
    UITableView *newTableView;
    UILabel *biaoQingLable;

}
@property (nonatomic, retain) IBOutlet UILabel *lableDate;
@property (nonatomic, retain) IBOutlet UIDatePicker *dataPicker;
- (IBAction)clickDatePicker:(id)sender;
- (IBAction)getTime:(id)sender;
@property (nonatomic, retain) IBOutlet UITextView *textContent;
@property (nonatomic, retain) IBOutlet UITextField *titleText;
- (IBAction)saveText:(id)sender;

@property (nonatomic,retain) IBOutlet UITableView *newTableView;

@property (nonatomic, retain) IBOutlet UILabel *biaoQingLable;

@end
