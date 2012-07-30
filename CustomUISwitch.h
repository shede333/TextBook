//
//  CustomUISwitch.h
//  TestSwitch
//
//  Created by Roy on 11-9-17.
//  Copyright 2011年 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol CustomUISwitchDelegate;



@interface CustomUISwitch : UIControl {
    id<CustomUISwitchDelegate> _delegate;
    BOOL _on;
    CGRect frameBG;
    CGRect frameSwitch;
    CGPoint pointLast;
    NSString *switchOffImageName;
    NSString *switchOnImageName;
    NSString *bgImageName;
    BOOL direction; // yes代表横向，no代表竖向
//    BOOL isTap; //yes代表tap，no代表pan
    float animateDuration;
    
    
    NSInteger _hitCount;
    UIImageView *_backgroundImage;
    UIImageView *_switchImage;
    UITapGestureRecognizer * tapGesture;
    UIPanGestureRecognizer * panGesture;
}
@property (nonatomic ,assign , readwrite) id delegate;
@property (nonatomic ,getter = isOn) BOOL on;

- (id)initWithFrame:(CGRect)frame;
- (void)setupUserInterfaceWithBGName:(NSString *)BGImageName andSwitchNameOn:(NSString *)switchImageNameOn andSwitchNameOff:(NSString *)switchImageNameOff;

//- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (BOOL)isOn;
- (void)setAnimateDuration:(float)duration;
- (void)setLight:(BOOL)isLight;

@end

@protocol CustomUISwitchDelegate

@optional

//- (void)valueChangedInView:(CustomUISwitch *)view;
- (void)actionRedSwitch:(CustomUISwitch *)view;

@end