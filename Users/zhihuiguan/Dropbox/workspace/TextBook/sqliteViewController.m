//
//  sqliteViewController.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-9.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "sqliteViewController.h"


static sqlite3 * dbSqlite = nil;

@implementation sqliteViewController
@synthesize inputTextField;
@synthesize lableShow;




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
}

- (void)viewDidUnload
{
    [self setInputTextField:nil];
    [self setLableShow:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.inputView resignFirstResponder];
    [self.lableShow resignFirstResponder];
}

- (void)dealloc {
    [inputTextField release];
    [lableShow release];
    [super dealloc];
}

#pragma mark - 自定义方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;{
    if (textField.tag == 1) {
        return NO;
    }
    return YES;
}






- (IBAction)actionDo:(id)sender {
    
 
}











#pragma mark - sqlite数据库执行方法
+ (sqlite3 *)getDB{
    if (dbSqlite) {
        return dbSqlite;
    }else{
        NSString *pathDB = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MonsterChat.sqlite"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:pathDB]) {
            return nil;
        }else{
            int result = sqlite3_open([pathDB UTF8String], &dbSqlite);
            if (result == SQLITE_OK) {
                return dbSqlite;
                
            }else{
                sqlite3_close(dbSqlite);
                return nil;
            }
        }
    }
    
}





@end
