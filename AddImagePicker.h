//
//  AddImagePicker.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-28.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImagePicker : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,retain) UIImagePickerController *imagePicker;

@end
