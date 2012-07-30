//
//  iBook.m
//  zzKVCSW
//
//  Created by Zhihuiguan Zhihuiguan on 12-4-24.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "iBook.h"

@implementation iBook
@synthesize name;

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    NSLog(@"sw-2-ibook-auto-key %@\n",key);
    return YES;
}


@end
