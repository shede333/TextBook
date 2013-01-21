//
//  TestCodingViewController.m
//  TextBook
//
//  Created by shaowei on 13-1-21.
//
//

#import "TestCodingViewController.h"

@interface TestCodingViewController ()

@end

@implementation TestCodingViewController
@synthesize textNumber;
@synthesize textString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                          NSUserDomainMask,
                                                          YES) lastObject];
    CodingModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:[path stringByAppendingPathComponent:@"test"]];
    if (model) {
        self.textNumber.text = [NSString stringWithFormat:@"%d",model.testint];
        self.textString.text = model.testString;
    }else{
        NSLog(@"SW - No Exist");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [textNumber release];
    [textString release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextNumber:nil];
    [self setTextString:nil];
    [super viewDidUnload];
}
- (IBAction)actionSave:(id)sender {
    CodingModel *model = [[CodingModel alloc] init];
    model.testint = [self.textNumber.text integerValue];
    model.testString = self.textString.text;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES) lastObject];
    [NSKeyedArchiver archiveRootObject:model toFile:[path stringByAppendingPathComponent:@"test"]];
    [model release];
}
@end
