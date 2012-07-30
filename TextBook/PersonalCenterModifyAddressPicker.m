//
//  PersonalCenterModifyAddressPicker.m
//  MonsterHunt
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-2.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "PersonalCenterModifyAddressPicker.h"
#import "DBManager.h"
#import "DBViewController.h"

@implementation PersonalCenterModifyAddressPicker
@synthesize target;
@synthesize callback;
@synthesize mutableArraySex;
@synthesize pickerAddress;
@synthesize dicAddressCity;
@synthesize dicAddressProv;
@synthesize dicAddressZone;
@synthesize arrAddressCity_value;
@synthesize arrAddressProv_value;
@synthesize arrAddressZone_value;
@synthesize initCity;
@synthesize initZone;
@synthesize initProvince;
@synthesize endCity;
@synthesize endZone;
@synthesize endProvince;

//@synthesize numberOfComponent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc{
    
    [initProvince release];
    [initCity release];
    [initZone release];
    [endProvince release];
    [endCity release];
    [endZone release];
    [dicAddressCity release];
    [arrAddressProv_value release];
    [arrAddressZone_value release];
    [arrAddressCity_value release];
    [dicAddressProv release];
    [dicAddressZone release];
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.arrAddressProv_value) {
        [self.arrAddressProv_value release];
        self.arrAddressProv_value = nil;
        [self.dicAddressProv release];
        self.dicAddressProv = nil;
    }
    self.dicAddressProv = [[NSDictionary alloc] initWithDictionary:[DBManager getReceiverProvDataSource]];
    self.arrAddressProv_value = [NSArray arrayWithArray:
                                 [[self.dicAddressProv allKeys] 
                                  sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
//    NSLog(@"self.dicAddressProv:%@\n self.arrAddressProv_value:%@",self.dicAddressProv,self.arrAddressProv_value);
    //初始化picker定位
    NSString *addressProLast = @"";
//    NSString *addressProTmp = @"江苏省";
    if (![addressProLast isEqualToString:@""] && addressProLast != nil) {
        //省部分 定位到上次
        int proNum = [self.arrAddressProv_value indexOfObject:addressProLast];
        [self.pickerAddress selectRow:proNum inComponent:0 animated:NO];
        
        //市部分 定位到上次
        if (self.dicAddressCity) {
            [self.dicAddressCity release];
            self.dicAddressCity = nil;
        }
        NSString *addressCityLast = @"";
        if (addressCityLast == nil || [addressCityLast isEqualToString:@""]) {
            self.arrAddressCity_value = nil;
            [self.pickerAddress reloadComponent:1];
            if (self.dicAddressZone) {
                [self.dicAddressZone release];
                self.dicAddressZone = nil;
            }
            self.arrAddressZone_value = nil;
            [self.pickerAddress reloadComponent:2];
            return;
            /**************************************************/
        }
        self.dicAddressCity = [[NSDictionary alloc] initWithDictionary:
                               [DBManager getReceiverCityDataSourceWithProvCode:
                                [self.dicAddressProv objectForKey:addressProLast]]];
        self.arrAddressCity_value = [self.dicAddressCity allKeys];
        [self.pickerAddress reloadComponent:1];
        int cityNum = 0;
//        int cityNum = [self.arrAddressCity indexOfObject:[NSString stringWithFormat:@"苏州市"]];
        [self.pickerAddress selectRow:cityNum inComponent:1 animated:NO];
        
        //区部分 定位到上次
        if (self.dicAddressZone) {
            [self.dicAddressZone release];
            self.dicAddressZone = nil;
        }
        
        NSString *addressZoneLast = @"";
        if (addressZoneLast == nil || [addressZoneLast isEqualToString:@""]) {
            self.arrAddressZone_value = nil;
            [self.pickerAddress reloadComponent:2];
        }else{
//            self.dicAddressZone = [[NSDictionary alloc] initWithDictionary:
//                                   [DBManager getReceiverZoneDataSourceWithCityCode:
//                                    [self.dicAddressCity objectForKey:
//                                     [DataHolder defaultInstance].userLoginBean.userAddressBig_city]]];
            self.arrAddressZone_value = [self.dicAddressZone allKeys];
            if ([self.arrAddressZone_value count] > 0) {
                [self.pickerAddress reloadComponent:2];
                int zoneNum = 0;
                [self.pickerAddress selectRow:zoneNum inComponent:2 animated:NO];
            }else{
                [self.pickerAddress reloadComponent:2];
            }
        
        }
        NSLog(@"初始化 给值- viewdidload-yes\n");
        
    }else if([self.arrAddressProv_value count] > 0){
        //省部分 定位到第一行
        [self.pickerAddress selectRow:0 inComponent:0 animated:NO];
        
        //市部分 定位到第一行
        if (self.dicAddressCity) {
            [self.dicAddressCity release];
            self.dicAddressCity = nil;
        }
        NSString *proCode = [self.arrAddressProv_value objectAtIndex:0];
        NSLog(@"proCode:%@\n",proCode);
        self.dicAddressCity = [[NSDictionary alloc] initWithDictionary:
                               [DBManager getReceiverCityDataSourceWithProvCode:
                                [self.dicAddressProv objectForKey:proCode]]];
        self.arrAddressCity_value = [self.dicAddressCity allKeys];
        [self.pickerAddress reloadComponent:1];
        if ([self.arrAddressCity_value count] > 0) {
            [self.pickerAddress selectRow:0 inComponent:1 animated:NO];
        }else{
            if ([self.arrAddressZone_value count] > 0) {
                [self.arrAddressZone_value release];
                self.arrAddressZone_value = nil;
            }
            [self.pickerAddress reloadComponent:2];
            return;
            /**************************************************/
        }
        
        //区部分 定位到第一行
        if (self.dicAddressZone) {
            [self.dicAddressZone release];
            self.dicAddressZone = nil;
        }
        NSString *cityCode = [self.arrAddressCity_value objectAtIndex:0];
        self.dicAddressZone = [[NSDictionary alloc] initWithDictionary:
                               [DBManager getReceiverZoneDataSourceWithCityCode:
                                [self.dicAddressCity objectForKey:cityCode]]];
        self.arrAddressZone_value = [self.dicAddressZone allKeys];
        [self.pickerAddress reloadComponent:2];
        if ([self.arrAddressZone_value count] > 0) {
            [self.pickerAddress selectRow:0 inComponent:2 animated:NO];
        }
        
        NSLog(@"初始化 自己第一回- viewdidload-yes\n");
    }
    NSLog(@"初始化 完毕\n");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - picker-source方法
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {  
            if ([self.arrAddressProv_value count] > 0) {
                return [self.arrAddressProv_value count];
            }else{
                return 0;
            }
            
        }
            break;
        case 1:
        {
            if ([self.arrAddressCity_value count] > 0) {
                return [self.arrAddressCity_value count];
            }else{
                return 0;
            } 
        }   
            break;
        case 2:
        {
            if ([self.arrAddressZone_value count] > 0) {
                return [self.arrAddressZone_value count];
            }else{
                return 0;
            } 
        }       
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}

#pragma mark - picker-delegate方法

// returns width of column and height of row for each component. 
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {  
            if ([self.arrAddressProv_value count] > 0) {
                return [self.arrAddressProv_value objectAtIndex:row];
            }else{
                return nil;
            }
            
        }
            break;
        case 1:
        {
            if ([self.arrAddressCity_value count] > 0) {
                return [self.arrAddressCity_value objectAtIndex:row];
            }else{
                return nil;
            } 
        }   
            break;
        case 2:
        {
            if ([self.arrAddressZone_value count] > 0) {
                return  [self.arrAddressZone_value objectAtIndex:row];
            }else{
                return nil;
            } 
        }       
            break;
            
        default:
            return nil;
            break;
    }
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {  
            NSLog(@"did-pro\n");
            //市部分 定位
            if (self.dicAddressCity) {
                [self.dicAddressCity release];
                self.dicAddressCity = nil;
            }
            NSString *proCode = [self.arrAddressProv_value objectAtIndex:row];
            self.dicAddressCity = [[NSDictionary alloc] initWithDictionary:
                                   [DBManager getReceiverCityDataSourceWithProvCode:
                                    [self.dicAddressProv objectForKey:proCode]]];
            self.arrAddressCity_value = [self.dicAddressCity allKeys];
            [self.pickerAddress reloadComponent:1];
            if ([self.arrAddressCity_value count] > 0) {
                [self.pickerAddress selectRow:0 inComponent:1 animated:NO];
            }else{
                //市 为空 的情况
                if (self.dicAddressZone) {
                    [self.dicAddressZone release];
                    self.dicAddressZone = nil;
                }
                self.arrAddressZone_value = nil;
                [self.pickerAddress reloadComponent:2];
                return;
                /**************************************************/
            }
          
            //区部分 定位
            if (self.dicAddressZone) {
                [self.dicAddressZone release];
                self.dicAddressZone = nil;
            }
            
            NSString *addressZoneLast = [self.arrAddressCity_value objectAtIndex:0];
            if (addressZoneLast == nil || [addressZoneLast isEqualToString:@""]) {
                self.arrAddressZone_value = nil;
                [self.pickerAddress reloadComponent:2];
            }else{
                self.dicAddressZone = [[NSDictionary alloc] initWithDictionary:
                                       [DBManager getReceiverZoneDataSourceWithCityCode:
                                        [self.dicAddressCity objectForKey:addressZoneLast]]];
                self.arrAddressZone_value = [self.dicAddressZone allKeys];
                if ([self.arrAddressZone_value count] > 0) {
                    [self.pickerAddress reloadComponent:2];
                    
                    [self.pickerAddress selectRow:0 inComponent:2 animated:NO];
                }else{
                    [self.pickerAddress reloadComponent:2];
                }
           
            }
            
            
        }    
            break;
        case 1:
        {    
             NSLog(@"did-city\n");
            if (self.dicAddressZone) {
                [self.dicAddressZone release];
                self.dicAddressZone = nil;
            }
            NSString *cityCode = [self.arrAddressCity_value objectAtIndex:row];
            self.dicAddressZone = [[NSDictionary alloc] initWithDictionary:
                                   [DBManager getReceiverZoneDataSourceWithCityCode:
                                    [self.dicAddressCity objectForKey:cityCode]]];
            self.arrAddressZone_value = [self.dicAddressZone allKeys];
            if ([self.arrAddressZone_value count] > 0) {
                [self.pickerAddress reloadComponent:2];
                [self.pickerAddress selectRow:0 inComponent:2 animated:NO];
            }else{
                [self.pickerAddress reloadComponent:2];
            }
            
           
            
        }
            break;
        default:
            break;
    }
}

-(void)invokeaddGuideLabelWithText:(NSString *)province city:(NSString *)city zone:(NSString *)zone{
    
    NSMethodSignature *sig= [[self.target class] instanceMethodSignatureForSelector:callback];
    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:self.target];
    [invocation setSelector:callback];
    [invocation setArgument:&province atIndex:2];
    [invocation setArgument:&city atIndex:3];
    [invocation setArgument:&zone atIndex:4];
    //retain 所有参数，防止参数被释放dealloc
    [invocation retainArguments];
    //消息调用
    //        [invocation invoke];
    [invocation performSelector:@selector(invoke)];
}
#pragma mark - 自定义-方法

- (IBAction)dismissOwn:(id)sender {
//    PersonalCenterModifyProfileViewController *modifyViewController = (PersonalCenterModifyProfileViewController *)self.target;
    
    int proRowSelected = [self.pickerAddress selectedRowInComponent:0];
    int cityRowSelected = [self.pickerAddress selectedRowInComponent:1];
    int zoneRowSelected = [self.pickerAddress selectedRowInComponent:2];
    
    //最终选择的 省
    if ([self.pickerAddress numberOfRowsInComponent:0] > 0) {
        if ([self.arrAddressProv_value count] > 0) {
            if ((proRowSelected +1 ) > [self.arrAddressProv_value count]) {
                self.initProvince = [self.arrAddressProv_value objectAtIndex:([self.arrAddressProv_value count]-1)];
            }else{
                self.initProvince = [self.arrAddressProv_value objectAtIndex:proRowSelected];
            }
            
        }else{
            self.initProvince = @"";
        }
        
    }else{
        self.initProvince = @"";
    }
    NSLog(@"省-完毕\n");
    
    //最终选择的 市
    if ([self.initProvince length] > 0) {
        if (self.dicAddressCity) {
            [self.dicAddressCity release];
            self.dicAddressCity = nil;
        }
        NSString *proCode = [self.arrAddressProv_value objectAtIndex:proRowSelected];
        self.dicAddressCity = [[NSDictionary alloc] initWithDictionary:
                               [DBManager getReceiverCityDataSourceWithProvCode:
                                [self.dicAddressProv objectForKey:proCode]]];
        self.arrAddressCity_value = [self.dicAddressCity allKeys];
        if ([self.arrAddressCity_value count] > 0) {
            if ((cityRowSelected + 1) > [self.arrAddressCity_value count]) {
                self.initCity = [self.arrAddressCity_value objectAtIndex:([self.arrAddressCity_value count] - 1)];
            }else{
                self.initCity = [self.arrAddressCity_value objectAtIndex:cityRowSelected];
            }
            
        }else{
            self.initCity = @"";
        }
        
    }else{
        self.initCity = @"";
    }
    NSLog(@"市-完毕\n");
    
    //最终选择的 区
   
    if ([self.initCity length] > 0) {
        if (self.dicAddressZone) {
            [self.dicAddressZone release];
            self.dicAddressZone = nil;
        }
        NSString *cityCode = [self.arrAddressCity_value objectAtIndex:0];
        self.dicAddressZone = [[NSDictionary alloc] initWithDictionary:
                               [DBManager getReceiverZoneDataSourceWithCityCode:
                                [self.dicAddressCity objectForKey:cityCode]]];
        self.arrAddressZone_value = [self.dicAddressZone allKeys];
        if ([self.arrAddressZone_value count] > 0) {
            if ((zoneRowSelected + 1) > [self.arrAddressZone_value count]) {
                self.initZone = [self.arrAddressZone_value objectAtIndex:([self.arrAddressZone_value count] - 1)];
            }else{
                self.initZone = [self.arrAddressZone_value objectAtIndex:zoneRowSelected];
            }
          
        }else{
            self.initZone = @"";
        }
        
    }else{
        self.initZone = @"";
    }
    NSLog(@"区-完毕\n");
    
    
    [self invokeaddGuideLabelWithText:self.initProvince city:self.initCity zone:initZone];
}
@end
