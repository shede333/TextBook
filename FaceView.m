//
//  FaceView.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-27.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "FaceView.h"

static int scrollImageNum = 4;

@implementation FaceView
@synthesize scrollView;
@synthesize pageController;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //scroll的初始化
    [self initScrollView];
    
    //pageController的初始化
    [self initPageController];
    
    
}

- (void)initScrollView{
    [self.scrollView setPagingEnabled:YES];
    self.scrollView.contentSize = CGSizeMake(320 * scrollImageNum ,
                                             self.scrollView.frame.size.height);
    
    [self.scrollView setBackgroundColor:[UIColor blueColor]];
	[self.scrollView setCanCancelContentTouches:NO];
	self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.scrollView.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	self.scrollView.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	self.scrollView.pagingEnabled = YES;
    
    
    int i = 0;
    for (i = 0; i < scrollImageNum; i ++) {
        NSString *stringTmp = [NSString stringWithFormat:@"表情%d",i+1];
        NSString *pathOfImage = [[NSBundle mainBundle] pathForResource:stringTmp ofType:@"png"];
        UIImage *imageTmp = [[UIImage alloc] initWithContentsOfFile:pathOfImage];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageTmp];
        [imageTmp release];
        CGRect frame = self.scrollView.frame;
        imageView.frame = CGRectMake(frame.size.width * i,
                                     0,
                                     frame.size.width,
                                     frame.size.height);
        [self.scrollView addSubview:imageView];
        [imageView release];
        
    }
}

- (void)initPageController{
    [self.pageController setNumberOfPages:scrollImageNum ];
    [self.pageController addTarget:self 
                            action:@selector(changePage:) 
                  forControlEvents:UIControlEventValueChanged];
}

//点击pageController产生的动作
- (void)changePage:(id)sender{
    int page = self.pageController.currentPage;
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        CGRect frame = scrollView.frame;
        int page = floor(frame.origin.x / frame.size.width) + 1;
        self.pageController.currentPage = page;
    }
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [scrollView release];
    [pageController release];
    [super dealloc];
}
@end
