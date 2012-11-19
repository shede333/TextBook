//
//  TextBookViewController.m
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TextBookViewController.h"
#import "TextBookAppDelegate.h"
#import "NewText.h"
#import "LookText.h"
#import "TextBookAppDelegate.h"
#import "ceng.h"
#import "fengHuoLun.h"
#import "alertController.h"
#import "DongHua.h"
#import "DBViewController.h"
#import "sqliteViewController.h"
#import "FileManager.h"
#import "ChatWindow.h"
#import "FaceView.h"
#import "SWMotionManager.h"
#import "Animation.h"
#import "CameraSW.h"
#import "ImageAnimatoon.h"
#import "MediaPlayerSW.h"
#import "KeyBoardSW.h"
#import "AddImagePicker.h"
#import "CopyPasteTextController.h"
#import "JsonIOSSW.h"
#import "Transform3DSW.h"
#import "TableViewMoveAndDelete.h"
#import "GraphicsViewController.h"
#import "HitTestViewController.h"
#import "KVOViewController.h"
#import "WebViewFileViewController.h"
#import "ButtonViewController.h"



typedef  NSString* (^bblock)(int);

static int TIME_INTERVAL = 6;
static int INT_TIMER = 3;
static float FLOAT_TIMER = 10.0f;

@interface TextBookViewController()

//实现屏幕截图
- (void)getScreenshot;

@end

@implementation TextBookViewController
@synthesize wTableView;

- (void)dealloc
{
    [av release];
    [timerTest release];
    [wTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)setBadgeNumber:(NSUInteger)number{
    if (number == 0) {
        badgeView_.badgeString = @"0";
        badgeView_.hidden = YES;
    }else{
        if (number > 99) {
            // 由于显示有问题, 大于99条的时候,还是显示 99
            badgeView_.badgeString = @"99";
        }else{
            badgeView_.badgeString = [NSString stringWithFormat:@"%d",number];
        }
        badgeView_.hidden = NO;
    }
    
}

#pragma mark - 初始化

- (IBAction)alertTest{

}

//plist文件读取
- (void)k_plist{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"faq" ofType:@"plist"];
//    [path stringByAppendingPathComponent:<#(NSString *)#>];
//    [path stringByAddingPercentEscapesUsingEncoding:<#(NSStringEncoding)#>];
    NSMutableArray * arrList = [[NSMutableArray alloc] initWithContentsOfFile:path];
//    NSMutableArray *tmpArray = [[[NSMutableArray alloc] initWithContentsOfFile:path] allkeys];
    NSLog(@"arrList:%@",arrList);
    [arrList release];
    NSDictionary *dicPlist = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"dicPlist:%@\n",dicPlist);
    arrList = [dicPlist allKeys];
    for (NSString *ss in arrList) {
        NSLog(@"arr:%@\n",ss);
    }
    [dicPlist release];
    
    NSMutableDictionary *writeDicList = [[NSMutableDictionary alloc] init];
//    [writeDicList setObject:@"什么是“刹客”？" forKey:@"在真实世界中埋伏着很多不为人所知的怪物……只有刹客，才能探测到它们的存在。
//     在任何地方，打开“刹客”捕捉怪物。享受赚取金币的快感，获得刹客特级荣誉，结识更多私密死党。随时随地，等待刹客的行动。"];
//    
//    [writeDicList setObject:@"如何才能找到怪物？" forKey:@"怪物行踪不定。请用“探测仪”寻找怪物行踪。可用“雷达”扫描，也可使用“地图”模式寻找，红点表示怪物地理位置，红点越密集地方，怪物数量越多。"];
//    
//    [writeDicList setObject:@"根据雷达/地图显示位置，依然找不到怪物怎么办？" forKey:@"打开“捕捉器”，移动镜头向四周看看。当怪物靠近时，屏幕上将出现红色闪烁箭头，提示怪物的方位。追随红色信号，怪物的面目很快就会出现啦！"];
//    
//    [writeDicList setObject:@"地图显示位置与实际所在位置不相符？" forKey:@"很遗憾，有时候位置的信息会因为环境而有所偏差。如被高楼大厦遮挡。建议重新探测，或者到相对开阔的地方试试吧。"];
//    
//    [writeDicList setObject:@"怎么样捕捉怪物？" forKey:@"打开“捕捉器”，若屏幕中出现怪物，请快速按下红色快门。记住，动作一定要快！狡猾的怪物随时会溜走。当怪物被捕捉后会挣扎进入管道，到达怪物瓶中。"];
    NSArray * pathsArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * pathW = [pathsArr objectAtIndex:0];
//    [pathW ];
    NSLog(@"pathW%@\n",pathW);
    [writeDicList writeToFile:[pathW stringByAppendingPathComponent:@"ss.plist"] atomically:YES ];
    
}

 //plist文件读取
- (void) pLIst{
    NSDictionary * Data = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"faqNew" ofType:@"plist"]];
    NSMutableArray *arrList = [[NSMutableArray alloc] initWithArray:[Data allKeys]];
    
    NSLog(@"arr:%@",arrList);
    NSLog(@"Data%d",[Data count]);
	NSLog(@"Data%d",[Data retainCount]);
	NSLog(@"Data%@",Data);
    
    
    
    NSString * fileUrlTitle = [[NSBundle mainBundle] pathForResource:@"faq_title" ofType:@"plist"];
    NSString * fileUrlContnet = [[NSBundle mainBundle] pathForResource:@"faq_content" ofType:@"plist"];
    //    NSLog(@"FileURL:%@",fileUrl);
   NSDictionary* dictionaryDataSourceTitle = [[NSDictionary alloc] initWithContentsOfFile:fileUrlTitle];
   NSDictionary* dictionaryDataSourceContent = [[NSDictionary alloc] initWithContentsOfFile:fileUrlContnet];
    NSLog(@"t:%@,c:%@\n",[dictionaryDataSourceTitle objectForKey:@"0"],[dictionaryDataSourceContent objectForKey:@"0"]);
}

- (void)rangeTest{
    NSString *tRange = @"shaowei";
    if ([tRange rangeOfString:@"wwei"].location == NSNotFound) {
        NSLog(@"not-found\n");
    }else{
        NSLog(@"found\n");
    }
}


- (void)test{
    NSArray *arrp = [[NSArray alloc] init];
    NSString *aarr = [arrp objectAtIndex:0];
    NSString *nn = @"";
    NSLog(@"nn:%d\n",[nn length]);
    NSString *cc = [[NSString alloc] initWithFormat:@"cc"];
    NSString *dd = cc;
    [cc release];
    NSLog(@"dd:%@\n",dd);
    NSArray *arrtt = [[NSArray alloc] initWithArray:nil]; 
    NSString *aa = [[NSString alloc] initWithFormat:@"first"];
    
    NSString *bb = aa;
    bb = [bb stringByAppendingFormat:@"22222"];
//    bb = @"shdu";
    NSArray * arr = [[NSArray alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *tString  = [[NSString alloc] initWithFormat:@"0000"];
    NSString *tString1  = [[NSString alloc] initWithFormat:@"11111"];
    
    NSLog(@"1:%d\n",[tString retainCount]);
    
    [dic setObject:tString forKey:@"0"];
    [dic setObject:tString1 forKey:@"1"];
    NSLog(@"2:%d\n",[tString retainCount]);
    
    NSArray *arrValue = [dic allValues];
    [dic release];
//    NSArray *arrKey = [dic allKeys];
    NSLog(@"arr:%@\n",arrValue);
//    NSString *value = [arrValue objectAtIndex:0];
//    NSLog(@"arr0:%d,string0:%d,arr1:%d,tString:%d\n",[[arrValue objectAtIndex:0] retainCount],[value retainCount],[[arrValue objectAtIndex:1] retainCount],[tString retainCount]);
    
    
    NSLog(@"aa:%@,bb:%@,%@\n",aa,bb,[arr objectAtIndex:0]);
}

//array 数组比较
- (void)arraySortByBlock{
    NSMutableArray *ar = [[NSMutableArray alloc] initWithCapacity:5];
    
    NSArray *addr1 = [[NSArray alloc] initWithObjects:@"111",@"南京",@"23", nil];
    NSArray *addr2 = [[NSArray alloc] initWithObjects:@"41",@"北京",@"03", nil];
    NSArray *addr3 = [[NSArray alloc] initWithObjects:@"91",@"东京",@"23", nil];
    
    [ar addObject:addr1];
    [ar addObject:addr2];
    [ar addObject:addr3];
    
    [addr1 release];
    [addr2 release];
    [addr3 release];
    
    NSLog(@"origin: %@", ar);
    
//    [ar sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]
    
    [ar sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSArray *o1 = (NSArray *)obj1;
        NSArray *o2 = (NSArray *)obj2;
        
        NSString *str1 = [o1 objectAtIndex:1];
        NSString *str2 = [o2 objectAtIndex:1];
        NSComparisonResult rst = [str2 localizedCaseInsensitiveCompare:str1];
        return rst;
        
    }];
    
    NSLog(@"after :%@", ar);
    [ar release];
}

- (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    //    [formatter setPMSymbol:@"下午"];
    //    [formatter se*****Symbol:@"上午"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *nowTime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    return nowTime;
}

- (void)testWriteData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_03685557" ofType:@"png"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSString *wPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/hh/ii.png"];
    BOOL flag = [data writeToFile:wPath atomically:YES];
    if (flag) {
        NSLog(@"sw-2-chengg \n");
    }else{
        NSLog(@"sw-2-shibai \n");
    }
    
    NSLog(@"sw-2- \n");
    
}

- (void)testOfMath{
    float tt = 53.0f;
    int result = (int)floor(tt/10);
    NSLog(@"sw-2-re %d\n",result);
    
    result = (int)round(tt/10);
    NSLog(@"sw-2-re %d\n",result);
    
    result = (int)nearbyintf(tt/10);
    NSLog(@"sw-2-re %d\n",result);
    
    tt = 56.0f;
    
    result = (int)round(tt/10);
    NSLog(@"sw-2-re %d\n",result);
    
    result = (int)round(tt/10);
    NSLog(@"sw-2-re %d\n",result);
    
    result = (int)nearbyintf(tt/10);
    NSLog(@"sw-2-re %d\n",result);
    
    int dd = 56;
    NSLog(@"sw-2-re %d\n",dd/10);
    
    NSLog(@"sw-2- \n");
}

- (void)dicAdd{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"111",@"2222", nil];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:arr,@"arr", nil];
    [(NSMutableArray *)[dic objectForKey:@"arr"] addObject:@"3333"];
    NSLog(@"sw-2-dic %@\n",dic);
    
    
    NSMutableArray *mArr = (NSMutableArray *)[dic objectForKey:@"marr"];
    if ([mArr count] == 0) {
        NSLog(@"sw-2-nil \n");
    }
    
    
    
    NSArray *pathArray = [NSArray arrayWithObjects:@"here", @"be", @"dragons", nil];
    NSLog(@"%@",[pathArray componentsJoinedByString:@" "]);
    
    
    
    NSLog(@"sw-2- \n");
}


- (void)arrCompare{
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"2010.01.25",@"2011.01.25",@"2010.1.26",@"2010.1.24",@"2010.01.24",@"2010.01.26",@"2010.03.25", nil];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *ob1 = (NSString *)obj1;
        NSString *ob2 = (NSString *)obj2;
        return [ob2 compare:ob1 options:NSNumericSearch];
    }];
    
    NSLog(@"sw-2-arr %@\n",arr);
    
    NSLog(@"sw-2- \n");
    
}

- (void)arrOfCount{
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:20];
    [mArr addObject:@"sdiu"];
    [mArr addObject:@"sdiu"];
    NSLog(@"sw-2-marr %d\n",[mArr count]);
    NSLog(@"sw-2- \n");
}

- (void)dicTestChange{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    [dic setObject:@"ob1" forKey:@"k1"];
        [dic setObject:@"ob2" forKey:@"k2"];
        [dic setObject:@"ob3" forKey:@"k3"];
        [dic setObject:@"ob4" forKey:@"k4"];
    
    NSMutableDictionary *subMdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    [dic setObject:@"ob5" forKey:@"k5"];
    
    NSLog(@"sw-2-subMdic %@\n",subMdic);
    
    
    [dic release];
    
    
    NSLog(@"sw-2- \n");
}

- (void)getdocument{
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arr objectAtIndex:0];
    NSLog(@"sw-2- %@,\n%@\n%@\n%@\n",path,NSOpenStepRootDirectory(),NSTemporaryDirectory(),NSHomeDirectory());
    NSLog(@"sw-2- \n");
}

- (void)dicChange{
    NSMutableDictionary *dicm = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"jkbsvdvalue",@"key1", nil];
    [dicm setObject:@"value2" forKey:@"key2"];
    NSArray *arr = [[NSArray alloc] initWithObjects:dicm, nil];
    
    NSDictionary *dic = [arr lastObject];
    
    NSLog(@"sw-2-dic %@\n",dic);
    
    NSLog(@"sw-2- \n");
    
    
    
    
    
    [dicm release];
    [arr release];
}

- (void)testLable{
    NSString *sss = @"sdahgfs 哦四大后";
    CGSize size= [sss sizeWithFont:[UIFont systemFontOfSize:14]];
    NSLog(@"sw-2-size %f\n",size.height);
    NSLog(@"sw-2- \n");
}

- (void)testSuanshu{
    int i =0;
    for (i = 0; i < 30; i++) {
        NSLog(@"sw-2- %d:%d,%d \n",i,i/7*10,(i%7));
    }
    NSLog(@"sw-2- \n");
}

- (void)suiji{
    NSString *gg = @"12345";
    gg = [gg substringWithRange:NSMakeRange(0, [gg length]-2)];
    NSLog(@"sw-2- %@\n",gg);
    NSLog(@"sw-2- \n");
}

- (void)blockdd{
    NSString *gg = @"dd";
    NSString * (^my1Block)(int,NSString *) = ^(int ii,NSString * fg){
        return fg;
    };
    
    NSLog(@"sw-2- %@\n",my1Block(1,@"skdug"));
    NSLog(@"sw-2- \n");
    int (^blockk)(int) = ^(int is){
        return is;
    };
    
    int (^myBlock)(int) = ^(int num) {
        return num ;
    };
    
//    qsort_b(<#void *#>, <#size_t#>, <#size_t#>, <#^int(const void *, const void *)#>)
}

- (void)blocktt{
    
    NSString *(^sbblock)(int);
    sbblock= ^(int hh){
        NSString *tt = @"sdisusuidh";
        return tt;  
    };
    
    
    __block int i = 0;
    __block NSString *ipo = [[NSString alloc] initWithFormat:@"ioi"];
    
    NSString *uustring = [[NSString alloc] initWithFormat:@"ioi"];
    NSLog(@"sw-2-first %d\n",[ipo retainCount]);
    
    
    bblock uu;
    bblock yy;
    uu = ^(int hh){
        ipo = uustring;
//        NSString *hh = [uustring retain];
        
        NSLog(@"sw-2-sec %d\n",[ipo retainCount]);
        i=9;
        NSString *tt = @"uuuuuuuuuusdisusuidh";
        return tt;  
    };
    
    Block_release(uu);
    
     yy = Block_copy(uu);
    
    NSLog(@"sw-2-thir %d\n",[ipo retainCount]);
    
    NSString *jj = uu(89);
    NSLog(@"sw-2-fff %@\n",yy(99));
    NSLog(@"sw-2- \n");
    
   
    
    
    
//    NSArray *array = [NSArray arrayWithObjects: @"A", @"B", @"C", @"A", @"B", @"Z",@"G", @"are", @"Q", nil];
//    NSSet *filterSet = [NSSet setWithObjects: @"A", @"Z", @"Q", nil];
//    BOOL (^test)(id obj, NSUInteger idx, BOOL *stop);
//    test = ^ (id obj, NSUInteger idx, BOOL *stop) {
//        if (idx < 5) {
//            if ([filterSet containsObject: obj]) {
//                return YES;
//            }
//            return NO;
//        }
//    };
//    NSIndexSet *indexes = [array indexesOfObjectsPassingTest:test];
//    NSLog(@"indexes: %@", indexes);
    
    NSLog(@"sw-2- \n");
    
    
    //    float dd = (^shd)(int ii){
    //        return 99;
    //    };
    
    //    int (^myBlock)(int) = ^(int num) {
    //        return 99;  
    //    };
    //    
    //    shd uu;
    //    
    //    float iii = uu
    
    //    uu = ^(int jj){
    //        return 99;
    //    };
    
    
    //    NSComparator finderSortBlock = ^(id string1, id string2) {
    //        NSRange string1Range = NSMakeRange(0, [string1 length]);
    //        return [string1 compare:string2 options:comparisonOptions range:string1Range locale:currentLocale];
    //    };
    
    
    //    float shd m = ^(int ii){
    //        NSLog(@"sw-2- %d\n",ii);
    //        return 1.0f;
    //    };
}

- (void)arrString{
    NSArray *arr = [[NSArray alloc] initWithObjects:@"jiayou",@"7777", nil];
    NSString *ss = [arr componentsJoinedByString:@","];
    NSLog(@"sw-2- %@\n",ss);
    NSLog(@"sw-2- \n");
}

- ( void )imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:( void  *)contextInfo {  
    NSString *message;  
    NSString *title;  
    if  (!error) {  
        title = NSLocalizedString(@"SaveSuccessTitle" , @ "" );  
        message = NSLocalizedString(@"SaveSuccessMessage" , @ "" );  
    } else  {  
        title = NSLocalizedString(@"SaveFailedTitle" , @ "" );  
        message = [error description];  
    }  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title  
                                                    message:message  
                                                   delegate:nil  
                                          cancelButtonTitle:NSLocalizedString(@"ButtonOK" , @ "" )  
                                          otherButtonTitles:nil];  
    [alert show];  
    [alert release];  
}  

- (void)twoImage{
    UIImage *image1 = [UIImage imageNamed:@"cover_0.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"110.png"];
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    [image2 drawInRect:CGRectMake(10, 10, image2.size.width, image2.size.height)];
    UIImage *imageFinal = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CGImageRef ref = imageFinal.CGImage;
    CGRect frame = CGRectMake(20, 20, 150, 150);
    CGImageRef ref1 = CGImageCreateWithImageInRect(ref, frame);
    UIImage *imageOfR = [UIImage imageWithCGImage:ref1];
    
    
    UIImageView *iView = [[UIImageView alloc] initWithImage:imageOfR];
    iView.center = CGPointMake(100, 200);
    [self.view addSubview:iView];
    
    UIImageWriteToSavedPhotosAlbum(imageOfR, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)testPin:(void *)pin{
    
//    NSLog(@"sw-2- :%d\n",(int)(*pin));
//    printf("test:%d",*pin);
}

- (void)actionPin{
    int ii = 10;
    NSString *hh = @"test";
    [self testPin:&ii];
    NSLog(@"sw-2- \n");
}

- (void)stringOfNum{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
    NSLocale *l_en = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];  
    NSLocale *l_de = [[NSLocale alloc] initWithLocaleIdentifier: @"de_DE"];  
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];  
    [f setLocale: l_en];  
    
    NSLog(@"returned: %@", [f numberFromString: @"1.234"]);  
    
    [f setAllowsFloats: NO];  
    NSLog(@"returned: %@", [f numberFromString: @"1.234"]);  
    
    [f setAllowsFloats: YES];  
    NSLog(@"returned: %@", [f numberFromString: @"1,234"]);  
    
    [f setLocale: l_de];  
    NSLog(@"returned: %@", [f numberFromString: @"1,234"]);  
    
    [l_en release];  
    [l_de release];  
    [f release];  
    [pool release];  
}



- (void) viewDidLoad{
    
    [self performSelector:@selector(getScreenshot) withObject:nil afterDelay:2];
    
    [self stringOfNum];
    
//    [self actionPin];
    
//    [self twoImage];
    
//    [self arrString];
    
//    [self blocktt];
    
    
//    [self blockdd];
    
//    [self suiji];
    
//    [self testSuanshu];
    
//    [self testLable];
    
//    [self dicChange];
    
//    [self getdocument];
    
//    [self dicTestChange];
    
//    [self arrOfCount];
    
    
//    [self arrCompare];
    
    
//    [self dicAdd]; 
    
//    [self testOfMath];
    
    
//    [self testWriteData];
    
    
//    NSString *ssb = [self getCurrentTime];
//    NSLog(@"sw-2-ssb: %@\n",ssb);
//    if ([[NSString stringWithFormat:@"success"] isEqual:@"success"]) {
//        NSLog(@"sw-2- \n");
//    }
//    NSArray *arrrr = [[NSArray alloc] initWithObjects:@"11",@"22",nil];
//    if ([arrrr containsObject:[NSString stringWithFormat:@"22"]]) {
//        NSLog(@"sw-2- \n");
//    }
    
//    Animation *aa = [[Animation alloc] init];
//    aa.test = @"";
    
//    [self performSelector:@selector(arraySortByBlock)];
    
//    [self test];
    
    //test-range
//    [self rangeTest];
    
    //plist文件读取
//    [self pLIst];
   
//    [self performSelector:@selector(k_plist)];
    
    
    
    
    
//    [av addButtonWithTitle:@"title"];
//    [self alertTest];
    
    
    
    [self searchFile];
    
    badgeView_ = [[UIBadgeView alloc] initWithFrame:CGRectMake(25, 150, 30, 30)];
    badgeView_.badgeColor = [UIColor yellowColor];
    [self.view addSubview:badgeView_];
    [self setBadgeNumber:10];
    
    
    if (timerTest) {
        NSLog(@"sssss\n");
    }
    
    
    NSMutableDictionary *dicVIP = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"001",@"userid",@"刹客团队",@"nickname",@"你好，我是刹客客服",@"infvalue",@"ttt",@"inftime",nil];
    NSLog(@"dicVIP:%@\n",dicVIP);
    
    
//按钮长按1
//    UILongPressGestureRecognizer *longPressGR =
//    [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                  action:@selector(handleLongPress:)];
//    longPressGR.minimumPressDuration = 0.2;
//    [self addGestureRecognizer:longPressGR];
//    [longPressGR release];
//    
//    
//    - (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer {
//        NSLog(@"LONG PRESS");
//    } 
    
//按钮长按2
    
//    
//    对 加个 longPressGesture ，设置如下：
//    UILongPressGestureRecognizer *pahGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
//                                                                                                       action:@selector(longPressGestureRecognizerStateChanged:)];    
//    
//    pahGestureRecognizer.delegate = self;     //指定委托
//    pahGestureRecognizer.minimumPressDuration = 0.3;     //最少按压响应时间
//    [scrollView addGestureRecognizer:pahGestureRecognizer];//指定对象为scrollView
//    [pahGestureRecognizer release];
//    实现委托方法：判断手势状态 动作开始、移动变化、结束
//    - (void)longPressGestureRecognizerStateChanged:(UIGestureRecognizer *)gestureRecognizer
//    {      
//        switch (gestureRecognizer.state)
//        {
//            case UIGestureRecognizerStateBegan:
//            {
//            }
//            case UIGestureRecognizerStateChanged:
//            {
//                
//            }
//            case UIGestureRecognizerStateEnded:
//            {
//            }
//        }
//        
//    } 
    
    //时间
//    NSDate * newDate = [NSDate date];
//    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
//    [dateformat setPMSymbol:@"下午"];
//    [dateformat setAMSymbol:@"上午"];
////    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];  hh:12小时，HH：24小时
//    [dateformat setDateFormat:@"yyyy.MM.dd AAA hh:mm aaa"];
//    
////    yyyyy.MMMM.dd GGG hh:mm aaa
//    NSString * newDateOne = [dateformat stringFromDate:newDate];
//    [dateformat setFormatterBehavior:NSDateFormatterFullStyle];
//    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    
    
    
    
    
//    NSLog(@"test::%@",newDateOne); 
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setLocale:[NSLocale systemLocale]];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    datePicker.date = [formatter dateFromString:self.textFieldAge.text];
//    [formatter release];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
//    [formatter setPMSymbol:@"下午"];
//    [formatter se*****Symbol:@"上午"];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss aa"];  // hh:12小时，HH：24小时
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSLog(@"test::%@",str); 
    
    
    timerTest = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(alertTest) userInfo:nil repeats:NO];
    
    
    
    NSMutableArray *arrTmp2 = [[NSMutableArray alloc] initWithCapacity:10];
    [arrTmp2 addObject:@"1"];
     [arrTmp2 addObject:@"2"];
     [arrTmp2 addObject:@"3"];
     [arrTmp2 addObject:@"4"];
     [arrTmp2 addObject:@"5"];
     [arrTmp2 addObject:@"1"];
    
    for (NSString *str in arrTmp2) {
        NSLog(@"str:%@\n",str);
    }
    
    
//    
//    NSDate *date = [NSDate date];
//    NSDate *oneMinuteFromNow = [date dateByAddingTimeInterval:60];
//    
//	NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
//	NSDateComponents *timerDateComponents = [calendar components:unitFlags fromDate:oneMinuteFromNow];
//	// Add one second to ensure time has passed minute update when the timer fires.
//	[timerDateComponents setSecond:1];
//	NSDate *minuteTimerDate = [calendar dateFromComponents:timerDateComponents];
//    
//	NSTimer *timer = [[NSTimer alloc] initWithFireDate:minuteTimerDate interval:60 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
//	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//	self.minuteTimer = timer;
//	[timer release];
    
    BOOL isTmp;
    
    if (isTmp) {
        NSLog(@"test-yes\n");
    }else{
        NSLog(@"test-no\n");
    }
    
    NSMutableArray *arrTmp1 = [[NSMutableArray alloc] initWithCapacity:10];
    if ([arrTmp1 count]>0) {
        NSLog(@"数组打消：%d\n",[arrTmp1 count]);
    }else{
        NSLog(@"数组长度为0\n");
    }
    
    [arrTmp1 release];
    
    
    
    self.title = @"记事本";
    
//    NSString *tt = @"";
//    tt = nil;
//    NSString * dd = [[NSString alloc] initWithString:tt];
    
    
    NSMutableDictionary *dicTmp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"shao'w'e'i",@"infvalue", nil];
    NSString *value = [dicTmp objectForKey:@"infvalue"];
    if ([value rangeOfString:@"'"].length > 0) {
        NSString *valueTmp = [[NSString alloc] initWithString:[value stringByReplacingOccurrencesOfString:@"'" withString:@"''"]];
        [dicTmp setObject:valueTmp forKey:@"infvalue"];
        [valueTmp release];
    }
    
    NSLog(@"dicTmp-test:%@\n",dicTmp);
    
    [dicTmp release];
    
    
    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/output.xml"];
    
//    NSString *path = @"/Users/zhihuiguan/Desktop/workspace/atest110/TextBook/TextBook/output.xml";
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"output.xml"];
    wdictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    //创建导航栏的按钮
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"新建"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self 
                                                                              action:@selector(newText:)] autorelease];
    
    //测试forin
    NSArray * arr1 = [[NSArray alloc] initWithObjects:@"11",@"22",@"33", nil];
    for (NSString * stringarr in arr1) {
        NSLog(@"外外\n");
        NSArray * arr2 = [[NSArray alloc] initWithObjects:@"11111",@"22222",@"3333333", nil];
        for (NSString * string2 in arr2) {
            NSLog(@"内内\n");
            break;
        }
        [arr2 release];
    }
    [arr1 release];
    
}

- (void)timerTestAction{
    NSLog(@"timer-timerTestAction\n");
//    NSLog(@"time:%@\n",[[[NSDate date] description] substringToIndex:19]);
    if (timerTest) {
        [timerTest invalidate];
        timerTest = nil;
    }
    timerTest = [NSTimer scheduledTimerWithTimeInterval:INT_TIMER target:self selector:@selector(tt) userInfo:nil repeats:NO];
}

- (IBAction)timerStart:(id)sender {
    //声音
    int inSystemSoundID = 1000;
    AudioServicesPlaySystemSound(inSystemSoundID);
    
    NSLog(@"timer-tt\n");
//    if (timerTest) {
//        NSLog(@"timer-清空\n");
//        [timerTest invalidate];
//        timerTest =nil;
//    }
//     timerTest = [NSTimer scheduledTimerWithTimeInterval:FLOAT_TIMER target:self selector:@selector(timerTestAction) userInfo:nil repeats:YES];
}

- (void)tt{
     NSLog(@"timer-tt\n");
//    NSLog(@"time:%@\n",[[[NSDate date] description] substringToIndex:19]);
    if (timerTest) {
        [timerTest invalidate];
        timerTest = nil;
    }
    timerTest = [NSTimer scheduledTimerWithTimeInterval:INT_TIMER target:self selector:@selector(timerTestAction) userInfo:nil repeats:NO];
}

- (IBAction)timerStop:(id)sender {
    [timerTest invalidate];
    timerTest =nil;
}

- (IBAction)switchChange:(id)sender {
    NSLog(@"switchChange-test\n");
}

#pragma mark - 遍历本地文件
- (void)searchFile{
//    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *documentDir = @"/Users/zhihuiguan/Desktop/AllCode";
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSFileManager *fileManager = [NSFileManager defaultManager];
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    NSLog(@"%@\n",fileList);
    for (NSString *fileName in fileList) {
        NSLog(@"fileName:%@\n",fileName);
    }
}


#pragma mark - 数据源 及 代理

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// TableViewCell 的个数；
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 32;
}

// TableViewCell 显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
/* cell重载
 static NSString *stringMain = @"MonsterBoxGiftView";
 UITableViewCell *cell = [tableviewMain dequeueReusableCellWithIdentifier:stringMain];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringMain];
 }else{
 for (UIView *subview in [cell subviews]){
 [subview removeFromSuperview];
 }
 }
 
 */
    
    UITableViewCell *wcell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wang"] autorelease];
    
    NSArray *wdkey = [[NSArray alloc] initWithArray:[wdictionary allKeys]];
   // wdkey = [wdkey sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
//    NSArray *tmpArr = [[NSArray alloc]initWithArray:[_dataSource allKeys]];
//    provArr = [[NSArray alloc] initWithArray:[tmpArr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
//    [tmpArr release];
    
    if (indexPath.row == 3) {
        wcell.textLabel.text = @"layer 层";
        
        return wcell;
    }
    
    if (indexPath.row == 4) {
        wcell.textLabel.text = @" fhl";
        
        return wcell;
    }
    
    if (indexPath.row == 5) {
        wcell.textLabel.text = @" alert";
        
        return wcell;
    }
    
    if (indexPath.row == 6) {
        wcell.textLabel.text = @" ASI下载";
        
        return wcell;
    }
    
    if (indexPath.row == 7) {
        wcell.textLabel.text = @"动画";
        
        return wcell;
    }
    
    if (indexPath.row == 8) {
        wcell.textLabel.text = @"数据库+picker地址";
        
        return wcell;
    }
    
    if (indexPath.row == 9) {
        wcell.textLabel.text = @"sqlite";
        
        return wcell;
    }
    
    if (indexPath.row == 10) {
        wcell.textLabel.text = @"FileManager";
        
        return wcell;
    }
    
    if (indexPath.row == 11) {
        wcell.textLabel.text = @"chat";
        
        return wcell;
    }
    
    if (indexPath.row == 12) {
        wcell.textLabel.text = @"scroll";
        
        return wcell;
    }
    
    if (indexPath.row == 13) {
        wcell.textLabel.text = @"accelerometer";
        
        return wcell;
    }
    
    if (indexPath.row == 14) {
        wcell.textLabel.text = @"MotionManager";
        
        return wcell;
    }
    
    if (indexPath.row == 15) {
        wcell.textLabel.text = @"Camera";
        
        return wcell;
    }
    
    if (indexPath.row == 16) {
        wcell.textLabel.text = @"ImageAnimation";
        
        return wcell;
    }
    
    if (indexPath.row == 17) {
        wcell.textLabel.text = @"Movie";
        
        return wcell;
    }
    
    if (indexPath.row == 18) {
        wcell.textLabel.text = @"KeyBoard";
        
        return wcell;
    }
    
    if (indexPath.row == 19) {
        wcell.textLabel.text = @"camera";
        
        return wcell;
    }
    
    if (indexPath.row == 20) {
        wcell.textLabel.text = @"pasteBoard";
        
        return wcell;
    }
    
    if (indexPath.row == 21) {
        wcell.textLabel.text = @"JSON";
        
        return wcell;
    }
    
    if (indexPath.row == 22) {
        wcell.textLabel.text = @"Transform3D";
        
        return wcell;
    }
    
    if (indexPath.row == 23) {
        wcell.textLabel.text = @"TableViewAndMoveAndDelete";
        
        return wcell;
    }
    
    if (indexPath.row == 24) {
        wcell.textLabel.text = @"GraphicsViewController";
        
        return wcell;
    }
    
    if (indexPath.row == 25) {
        wcell.textLabel.text = @"HitTestView";
        
        return wcell;
    }
    
    if (indexPath.row == 26) {
        wcell.textLabel.text = @"KVO-KVC";
        
        return wcell;
    }
    
    if (indexPath.row == 27) {
        wcell.textLabel.text = @"WebView";
        
        return wcell;
    }
    
    if (indexPath.row == 28) {
        wcell.textLabel.text = @"Button-EdgeInset";
        
        return wcell;
    }
    
    
    
    
    
  
    
    return wcell;
    
    
    
    
    
    
    
    wcell.textLabel.text = [wdkey objectAtIndex:indexPath.row];
    [wdkey release];
    
    wcell.accessoryType =UITableViewCellAccessoryDetailDisclosureButton;
    
    wcell.textLabel.backgroundColor = [UIColor clearColor];
    UIView *backgView = [[UIView alloc] initWithFrame:wcell.frame];
    backgView.backgroundColor = [UIColor colorWithRed:0.94
                                                green:0.94
                                                 blue:0.04
                                                alpha:1.0];
    wcell.backgroundView = backgView;
    [backgView release];
    

}

// TableViewCell 点击 跳转显示
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 3) {
        ceng *file = [[ceng alloc] initWithNibName:@"ceng" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        
        [file release];
        return;
    }
    
    if (indexPath.row == 4) {
        fengHuoLun *file = [[fengHuoLun alloc] initWithNibName:@"fengHuoLun" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 5) {
        alertController *file = [[alertController alloc] initWithNibName:@"alertController" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 7) {
        Animation *file = [[Animation alloc] initWithNibName:@"Animation" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 8) {
        DBViewController *file = [[DBViewController alloc] initWithNibName:@"DBViewController" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 9) {
        sqliteViewController *file = [[sqliteViewController alloc] initWithNibName:@"sqliteViewController" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 10) {
        FileManager *file = [[FileManager alloc] initWithNibName:@"FileManager" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 11) {
        ChatWindow *file = [[ChatWindow alloc] initWithNibName:@"ChatWindow" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 12) {
        FaceView *file = [[FaceView alloc] initWithNibName:@"FaceView" bundle:nil];
        
//        [self.navigationController pushViewController:file animated:YES];
        [self.navigationController.view addSubview:file.view];
        [file release];
        return;
    }
    
    if (indexPath.row == 13) {
        SWAccelerometer *file = [[SWAccelerometer alloc] initWithNibName:@"SWAccelerometer" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 14) {
        SWMotionManager *file = [[SWMotionManager alloc] initWithNibName:@"SWMotionManager" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 15) {
        CameraSW *file = [[CameraSW alloc] initWithNibName:@"CameraSW" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 16) {
        ImageAnimatoon *file = [[ImageAnimatoon alloc] initWithNibName:@"ImageAnimatoon" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 17) {
        MediaPlayerSW *file = [[MediaPlayerSW alloc] initWithNibName:@"MediaPlayerSW" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 18) {
        KeyBoardSW *file = [[KeyBoardSW alloc] initWithNibName:@"KeyBoardSW" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 19) {
        AddImagePicker *file = [[AddImagePicker alloc] initWithNibName:@"AddImagePicker" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 20) {
        CopyPasteTextController *file = [[CopyPasteTextController alloc] initWithNibName:@"CopyPasteTextController" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 21) {
        JsonIOSSW *file = [[JsonIOSSW alloc] initWithNibName:@"JsonIOSSW" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 22) {
        Transform3DSW *file = [[Transform3DSW alloc] initWithNibName:@"Transform3DSW" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 23) {
        TableViewMoveAndDelete *file = [[TableViewMoveAndDelete alloc] initWithNibName:@"TableViewMoveAndDelete" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 24) {
        ViewController *file = [[ViewController alloc] initWithNibName:@"GraphicsViewController" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 25) {
        HitTestViewController *file = [[HitTestViewController alloc] initWithNibName:@"HitTestViewController" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 26) {
        KVOViewController *file = [[KVOViewController alloc] initWithNibName:@"KVOViewController" bundle:nil];
 
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        return;
    }
    
    if (indexPath.row == 27) {
        WebViewFileViewController *file = [[WebViewFileViewController alloc] initWithNibName:@"WebViewFileViewController" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        
        return;
    }
    
    if (indexPath.row == 28) {
        ButtonViewController *file = [[ButtonViewController alloc] initWithNibName:@"ButtonViewController" bundle:nil];
        
        [self.navigationController pushViewController:file animated:YES];
        [file release];
        
        return;
    }
    
    
    
    
    
    return;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    LookText *wlookText =  [[LookText alloc] initWithNibName:@"LookText" bundle:nil];
    
//    wlookText.lookTableView = self.wTableView;
    
    
    [self.navigationController pushViewController:wlookText animated:YES];
    
    NSArray *tmpTitle = [[NSArray alloc] initWithArray:[wdictionary allKeys]];
    wlookText.lLableTime.text = [[tmpTitle objectAtIndex:indexPath.row] substringToIndex:19];
    wlookText.lTitle.text = [[tmpTitle objectAtIndex:indexPath.row] substringFromIndex:19];
    wlookText.lContent.text = [wdictionary objectForKey:[tmpTitle objectAtIndex:indexPath.row]];
    [tmpTitle release];
    [wlookText release];

//    [wTableView reloadData];
}

// 新建 按钮 
- (IBAction)newText:(id)sender {
    NewText *wnewText = [[NewText alloc] initWithNibName:@"NewText" bundle:nil];
    
    wnewText.newTableView = self.wTableView;
    [self.navigationController pushViewController:wnewText animated:YES];
    [wnewText release];
//    [wTableView reloadData];
    
}

// 重新载入tableView
//
- (void)viewWillAppear:(BOOL)animated{
    
    //    [self.wTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    self.wTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
//    NSString *path = @"/Users/zhihuiguan/Desktop/workspace/atest110/TextBook/TextBook/output.xml";
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"output.xml"];
    wdictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    [self.wTableView reloadData];
    
    
    //hud经典用例
//    TextBookAppDelegate *delegate = (TextBookAppDelegate *)[[UIApplication sharedApplication] delegate];
//    hud = [[MBProgressHUD alloc] ini];
//    
//    [self.view.window addSubview:hud];
//    hud.delegate = self;
//    hud.labelText = @"正在更新怪物信息...";
//    [hud showWhileExecuting:@selector(downloadMonsterForCatch) onTarget:self withObject:nil animated:YES];

//    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
//    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD]; 
	
//    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"Loading XXX";
//    [HUD showWhileExecuting:@selector(downloadMonsterForCatch) onTarget:self withObject:nil animated:YES];
    [HUD show:YES];
    [HUD hide:YES];

}

- (void)downloadMonsterForCatch{
    NSLog(@"test--start--sleep\n");
    [NSThread sleepForTimeInterval:6];
//    for (int i =0 ; i < 800000000000000000000; i++) {
//        
//    }
}

- (void)hudWasHidden{
    NSLog(@"test---hudWasHidden\n");
    [HUD removeFromSuperview];
    [HUD release];
}



#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setWTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

#pragma mark - 实现屏幕截图
- (void)getScreenshot{
    return;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    TextBookAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContext(delegate.window.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    //回到前台主线程执行
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *avs = [[UIAlertView alloc] initWithTitle:@"截图完成"
                                                     message:nil
                                                    delegate:nil
                                           cancelButtonTitle:@"YES"
                                           otherButtonTitles: nil];
        [avs show];
        [avs release];
    }) ;
    
    [pool release];
}


@end
