//
//  ViewController.h
//  zzKVCSW
//
//  Created by Zhihuiguan Zhihuiguan on 12-4-24.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBook.h"

@interface KVOViewController : UIViewController{
    iBook *myBook;
    NSString *myString;
    
}
@property ( nonatomic) IBOutlet UILabel *lableOfShow;

@property ( nonatomic) NSMutableArray *mArr;


- (IBAction)actionChange:(id)sender;

@end
