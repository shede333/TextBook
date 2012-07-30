//
//  CustomUISwitch.m
//  TestSwitch
//
//  Created by Roy on 11-9-17.
//  Copyright 2011年 Roy. All rights reserved.
//

#import "CustomUISwitch.h"

//#define SWITCH_DISPLAY_WIDTH 150.0
//#define SWITCH_WIDTH         113.0
//#define SWITCH_HEIGHT        44.0
//
//#define RECT_FOR_OFF         CGRectMake(37.0,0.0,SWITCH_WIDTH,SWITCH_HEIGHT)
//#define RECT_FOR_ON          CGRectMake(0.0,0.0,SWITCH_WIDTH,SWITCH_HEIGHT)
//#define RECT_FOR_HALFWAY     CGRectMake(18.5,0.0,SWITCH_WIDTH,SWITCH_HEIGHT)

@interface CustomUISwitch ()
@property (nonatomic ,retain ,readwrite) UIImageView *backgroundImage;
@property (nonatomic ,retain ,readwrite) UIImageView *switchImage;

- (void)mixGesture;
- (void)buttonPressed;
//- (void)toggle;
- (void)animateSwitch:(BOOL)toOn;
@end

@implementation CustomUISwitch
@synthesize backgroundImage=_backgroundImage;
@synthesize switchImage=_switchImage;
@synthesize delegate=_delegate;
@synthesize on=_on;

- (void)dealloc
{
    [bgImageName release];
    [switchOnImageName release];
    [switchOffImageName release];
    [panGesture release];
    [tapGesture release];
    [_backgroundImage release];
    [_switchImage release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) 
    {
        _on=YES;
        _hitCount=0;
        
        self.backgroundColor=[UIColor clearColor];
        self.clipsToBounds=YES;
        self.autoresizesSubviews=NO;
        self.autoresizingMask=0;
        self.opaque=YES;
        
        animateDuration = 0.1f;//动画时间
        
        
        frameBG = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        
        
        [self mixGesture];
//        [self setupUserInterface];
    }
    return self;
}

- (void)mixGesture{
    self.switchImage.userInteractionEnabled = YES;
    self.backgroundImage.userInteractionEnabled = YES;
    
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(actionPan:)];
    [self addGestureRecognizer:panGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(actionTap:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)actionPan:(id)sender{
//    NSLog(@"actionPan-拖动\n");
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    CGPoint point = [pan locationInView:self.backgroundImage];
    
//    if (direction) {
//        //横向
//        float x;
//        if ((point.x - frameSwitch.size.width / 2) < 0) {
//            x = frameSwitch.size.width / 2;
//        }else if((point.x + frameSwitch.size.width / 2) > frameBG.size.width){
//            x = frameBG.size.width - frameSwitch.size.width / 2;
//        }else{
//            x = point.x;
//        }
//        
//        self.switchImage.center = CGPointMake(x, self.switchImage.center.y);
//        
//        if (panGesture.state == UIGestureRecognizerStateEnded) {
//            NSLog(@"actionPan-拖动-完毕\n");
//            
//            if (point.x > (frameBG.size.width / 2)) {
//                x = frameBG.size.width - frameSwitch.size.width / 2;
//                _on = NO;
//            }else{
//                x = frameSwitch.size.width / 2;
//                _on = YES;
//            }
//            pointLast = CGPointMake(x, self.switchImage.center.y);
////            isTap = NO;
//            [self buttonPressed];
//        }
//        
//    }else{
        //竖向
        float y;
        if ((point.y - frameSwitch.size.height / 2) < 0) {
            y = frameSwitch.size.height / 2;
        }else if((point.y + frameSwitch.size.height / 2) > frameBG.size.height){
            y = frameBG.size.height - frameSwitch.size.height / 2;
        }else{
            y = point.y;
        }
        
         self.switchImage.center = CGPointMake(self.switchImage.center.x, y);
        
        if (panGesture.state == UIGestureRecognizerStateEnded) {
            NSLog(@"actionPan-拖动-完毕\n");
            
            if (point.y > (frameBG.size.height / 2)) {
                y = frameBG.size.height - frameSwitch.size.height / 2;
                _on = NO;
            }else{
                y = frameSwitch.size.height / 2;
                _on = YES;
            }
            pointLast = CGPointMake(self.switchImage.center.x, y);
//            isTap = NO;
            [self buttonPressed];
        }
        
       
        
//    }
    
    
    
}

- (void)actionTap:(id)sender{
    NSLog(@"actionTap-轻拍\n");
//    isTap = YES;
    _on=!_on;
    
    if (_on) {
//        if (direction) {
//           pointLast = CGPointMake(frameSwitch.size.width / 2, self.switchImage.center.y);
//        }else{
           pointLast = CGPointMake(self.switchImage.center.x, frameSwitch.size.height / 2); 
//        }
    }else{
//        if (direction) {
//            pointLast = CGPointMake((frameBG.size.width - frameSwitch.size.width / 2), self.switchImage.center.y);
//        }else{
            pointLast = CGPointMake(self.switchImage.center.x, (frameBG.size.height - frameSwitch.size.height / 2));
//        }
    }
    
    [self buttonPressed];
}

- (void)setupUserInterfaceWithBGName:(NSString *)BGImageName andSwitchNameOn:(NSString *)switchImageNameOn andSwitchNameOff:(NSString *)switchImageNameOff; 
{
    if (switchImageNameOn) {
        switchOnImageName = [[NSString alloc] initWithString:switchImageNameOn];
    }
    if (switchImageNameOff) {
        switchOffImageName = [[NSString alloc] initWithString:switchImageNameOff];
    }
    
    
//    bgImageName = [[NSString alloc] initWithString:BGImageName];
    
    UIImageView *bg=[[UIImageView alloc] initWithFrame:frameBG];
    bg.image=[UIImage imageNamed:BGImageName];
    bg.backgroundColor=[UIColor clearColor];
//    bg.contentMode=UIViewContentModeCenter;
    self.backgroundImage=bg;
    [bg release];
    
    UIImage *imageSwitch = [UIImage imageNamed:switchImageNameOff];
    CGImageRef refSwitch = imageSwitch.CGImage;
    float width = CGImageGetWidth(refSwitch);
    float height = CGImageGetHeight(refSwitch);
//    if (self.frame.size.width > self.frame.size.height) {
//        //横着放
//        direction = YES;
//        frameSwitch = CGRectMake(0, 0, (width * frameBG.size.height / height) , frameBG.size.height);
//    }else{
        //竖着放
        direction = NO;
        frameSwitch = CGRectMake(0, 0, frameBG.size.width, (height * frameBG.size.width / width));
//    }
    
    
    UIImageView *foreground=[[UIImageView alloc] initWithFrame:frameSwitch];
    foreground.image=imageSwitch;
//    foreground.contentMode=UIViewContentModeCenter;
    self.switchImage=foreground;
    [foreground release];
    
//    [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backgroundImage];
    [self.backgroundImage addSubview:self.switchImage];
}

//- (void)setOn:(BOOL)on animated:(BOOL)animated
//{
//    if (_on) {
//        self.switchImage.frame=RECT_FOR_ON;
//        self.backgroundImage.image=[UIImage imageNamed:bgImageName];
//    }
//    else
//    {
//        self.switchImage.frame=RECT_FOR_OFF;
//        self.backgroundImage.image=[UIImage imageNamed:bgImageName];
//    }
//}

- (BOOL)isOn
{
    return _on;
}

- (void)setAnimateDuration:(float)duration{
    animateDuration = duration;
}

- (void)setLight:(BOOL)isLight{

    if (isLight) {
        self.switchImage.image=[UIImage imageNamed:switchOnImageName];
    }else{
        self.switchImage.image=[UIImage imageNamed:switchOffImageName];
    }
}

- (void)buttonPressed
{
    NSLog(@"buttonPressed\n");
    [self animateSwitch:_on];
    
//    if (_hitCount == 0) {
//        _hitCount++;
//        [self toggle];
//    }
//    else
//    {
//        _hitCount++;
////        _on=!_on;
//    }
    
}

//- (void)toggle
//{
////    _on=!_on;
//    [self animateSwitch:_on];
//}

- (void)animateSwitch:(BOOL)toOn
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.1];
    
//    self.switchImage.frame=RECT_FOR_HALFWAY;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.1];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animateHasFinished:finished:context:)];
//    
//    self.switchImage.center = pointLast;
//    NSLog(@"pointLast:%f,%f\n",pointLast.x,pointLast.y);
//    
//    if (toOn) 
//    {
////        self.switchImage.frame=RECT_FOR_ON;
//        self.switchImage.center = pointLast;
//        self.backgroundImage.image=[UIImage imageNamed:bgImageName];
//    }
//    else
//    {
//        self.switchImage.frame=RECT_FOR_OFF;
//        self.backgroundImage.image=[UIImage imageNamed:bgImageName];
//    }
//    
//    [UIView commitAnimations];
//    
//    [UIView commitAnimations];
    
    if (_delegate) {
        [_delegate actionRedSwitch:self];
    }
    
    [UIView animateWithDuration:animateDuration animations:^{
        
        self.switchImage.center = pointLast;
        NSLog(@"pointLast:%f,%f\n",pointLast.x,pointLast.y);
        
    } completion:^(BOOL finished) {
        
        
        //    if (_hitCount>1) {
        //        _hitCount--;
        //        [self toggle];
        //       
        //    }
        //    else
        //    {
        //        _hitCount--;
        //    }
        NSLog(@"animateHasFinished:%d\n\n",_on);
        
      
        

    }];
    
}



- (void)animateHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context
{
//    if (_delegate) {
//        [_delegate valueChangedInView:self];
//    }
//    
////    if (_hitCount>1) {
////        _hitCount--;
////        [self toggle];
////       
////    }
////    else
////    {
////        _hitCount--;
////    }
//     NSLog(@"animateHasFinished:%d\n\n",_on);
//    
//    //shaowei
//    
//    if (_on) {
//        self.switchImage.image=[UIImage imageNamed:switchOnImageName];
//    }else{
//        self.switchImage.image=[UIImage imageNamed:switchOffImageName];
//    }
//    

}

@end
