//
//  ViewController.m
//  zzKVCSW
//
//  Created by Zhihuiguan Zhihuiguan on 12-4-24.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()
- (void)testCode;
@end

@implementation KVOViewController
//{
//    NSString *stringTest;
//}
@synthesize lableOfShow;
@synthesize mArr;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self testCode];
    
}

- (void)viewDidUnload
{
    [self setLableOfShow:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (void)testCode{
    NSMutableArray*tmpArr = [[NSMutableArray alloc] initWithCapacity:10];
    self.mArr = tmpArr;
    [self setValue:@"test1" forKey:@"myString"];
    myBook = [[iBook alloc] init];
    [self addObserver:self forKeyPath:@"myBook.name" options: NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:@"mArr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"myString" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - KVO-delegate
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"sw-2- \n keyPath: ***** %@\n object:%@ \n change:%@ \n",keyPath,object,change);

    
    
//    if ([[arr lastObject] isKindOfClass:[self class]]) {
//        NSLog(@"sw-2- \n");
//    }
//    NSLog(@"sw-2-arr %@\n",arr);
    
//    self.lableOfShow.text = [change valueForKey:@"new"];
}

//- (void)willChangeValueForKey:(NSString *)key{
//    NSLog(@"sw-2-will-change-key: %@\n",key);
//}
//
//- (void)didChangeValueForKey:(NSString *)key{
//    NSLog(@"sw-2-did-change-key: %@\n",key);
//}



- (IBAction)actionChange:(id)sender {
    int subRandom = arc4random()%10;
//    [self setValue:(id)[NSString stringWithFormat:@"book-name- keypath %d",subRandom] forKeyPath:@"myBook.name"];
    
    
   
    [self willChangeValueForKey:@"mArr"];
    [self willChangeValueForKey:@"myString"];

    
    [self setValue:(id)[NSString stringWithFormat:@"book-name- keypath %d",subRandom] forKeyPath:@"myBook.name"];
    
    [[self mutableArrayValueForKey:@"mArr"] addObject:[NSString stringWithFormat:@"mArr %d",subRandom]];
//    [mArr addObject:[NSString stringWithFormat:@"mArr %d",subRandom]];

    
//    myString = [NSString stringWithFormat:@"myString %d",subRandom];
    [self setValue:[NSString stringWithFormat:@"myString %d - set",subRandom] forKey:@"myString"];
    
 
    [self didChangeValueForKey:@"mArr"];
    [self didChangeValueForKey:@"myString"];
    
    
//    [myBook setValue:@"book-name - setValue" forKey:@"name"];
//    [myBook setName:@"setname"];
//    myBook.name = @".name";
    
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    NSLog(@"sw-2-auto-key %@\n",key);
    if ([key isEqual:@"myBook.name"]) {
        return YES;
    }
    return NO;
}

@end
