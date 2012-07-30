//
//  DBViewController.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-8.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterModifyAddressPicker.h"

@interface DBViewController : UIViewController<UITextFieldDelegate,UIPopoverControllerDelegate>{
    PersonalCenterModifyAddressPicker *personalAddressPicker;
    UIPopoverController *popover;
    NSString *pickerAddressPro;
    NSString *pickerAddressCity;
    NSString *pickerAddressZone;
}


@property (retain, nonatomic) PersonalCenterModifyAddressPicker *personalAddressPicker;
@property (retain, nonatomic) UIPopoverController *popover;
@property (retain, nonatomic) IBOutlet UITextField *textFieldTest;

@property (nonatomic, retain) NSString *pickerAddressPro;
@property (nonatomic, retain) NSString *pickerAddressCity;
@property (nonatomic, retain) NSString *pickerAddressZone;


- (void)dismissAddress:(NSString *)province andCity:(NSString *)city andZone:(NSString *)zone;

@end
