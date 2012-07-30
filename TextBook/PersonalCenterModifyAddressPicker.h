//
//  PersonalCenterModifyAddressPicker.h
//  MonsterHunt
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-2.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterModifyAddressPicker : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    id target;
    SEL callback;
    NSMutableArray *mutableArraySex;
    
    UIPickerView *pickerAddress;
//    NSInteger numberOfComponent;
    
    //用于存放省市区
    NSDictionary *dicAddressProv;
    NSArray *arrAddressProv_value;
    NSDictionary *dicAddressCity;
    NSArray *arrAddressCity_value;
    NSDictionary *dicAddressZone;
    NSArray *arrAddressZone_value;
    
    //用于初始化picker 的省市区
    NSString *initProvince;
    NSString *initCity;
    NSString *initZone;
    
    //用于存放最终选择的地址
    NSString *endProvince;
    NSString *endCity;
    NSString *endZone;
}

//@property (nonatomic) NSInteger numberOfComponent;
@property (nonatomic, retain)id target;
@property (nonatomic, assign) SEL callback;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerAddress;
@property (nonatomic, retain) IBOutlet NSMutableArray *mutableArraySex;

@property (nonatomic, retain) NSDictionary *dicAddressProv;
@property (nonatomic, retain) NSDictionary *dicAddressCity;
@property (nonatomic, retain) NSDictionary *dicAddressZone;
@property (nonatomic, retain) NSArray *arrAddressProv_value;
@property (nonatomic, retain) NSArray *arrAddressCity_value;
@property (nonatomic, retain) NSArray *arrAddressZone_value;
@property (nonatomic, retain) NSString *initProvince;
@property (nonatomic, retain) NSString *initCity;
@property (nonatomic, retain) NSString *initZone;
@property (nonatomic, retain) NSString *endProvince;
@property (nonatomic, retain) NSString *endCity;
@property (nonatomic, retain) NSString *endZone;

- (IBAction)dismissOwn:(id)sender;


@end
