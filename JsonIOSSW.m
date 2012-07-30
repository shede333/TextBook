//
//  JsonIOSSW.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-8.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "JsonIOSSW.h"

@implementation JsonIOSSW
@synthesize outShowTextView;

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.outShowTextView resignFirstResponder];
}

#pragma mark - action

- (void)show{
    NSURL *url = [NSURL URLWithString:@"http://maps.googleapis.com/maps/api/directions/json?origin=(31.290196,120.660156)&destination=(31.2548,%20120.6093)&sensor=false"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    id response = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingMutableContainers error:nil];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSLog(@"sw-2- %@\n",response);
        self.outShowTextView.text = [NSString stringWithFormat:@"sw:%@",response];
        NSDictionary *dic = (NSDictionary *)response;
        
        if ([[dic objectForKey:@"routes"] isKindOfClass:[NSArray class]]) {
            NSArray *arr = [dic objectForKey:@"routes"];
            if ([[arr lastObject] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *subDic = [arr lastObject];
                NSString *s2String = [[[[[subDic objectForKey:@"legs"] lastObject] objectForKey:@"steps"] lastObject] objectForKey:@"html_instructions"];
                NSLog(@"sw-2-s2String %@\n",s2String);
                
            }
        }
    
    }else{
        NSLog(@"sw-2- \n");
    }
}

- (IBAction)actionGet:(id)sender {
    [self show];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self show];
    self.outShowTextView.delegate = self;
}

- (void)viewDidUnload
{
    [self setOutShowTextView:nil];
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
    [outShowTextView release];
    [super dealloc];
}
@end
