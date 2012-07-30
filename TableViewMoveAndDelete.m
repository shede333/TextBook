//
//  TableViewMoveAndDelete.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-5-9.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "TableViewMoveAndDelete.h"

@interface TableViewMoveAndDelete ()

@end

@implementation TableViewMoveAndDelete
@synthesize myTableView;
@synthesize lableOfStatus;

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
    arrOfDataSource = [[NSMutableArray alloc] initWithCapacity:30];
    for (int i = 0; i<30; i++) {
        [arrOfDataSource addObject:[NSString stringWithFormat:@"这是第%d行！！！",i]];
    }
    myCellOfStatus = cellStatusOfNormal;
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setLableOfStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [arrOfDataSource release];
    [myTableView release];
    [lableOfStatus release];
    [super dealloc];
}

#pragma mark - tableView - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrOfDataSource count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifiler = @"cellOfNormal";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiler];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiler] autorelease];
        cell.showsReorderControl = YES; //move cell control UI
        
    }
    cell.textLabel.text = [arrOfDataSource objectAtIndex:indexPath.row];
    
    return cell;
}

//cell - Edit

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (myCellOfStatus) {
        case cellStatusOfEdit:
            return UITableViewCellEditingStyleNone;
            break;
        case cellStatusOfDelete:
            return UITableViewCellEditingStyleDelete;
            break;
            
        default:
            return UITableViewCellEditingStyleNone;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"deleteOfSure";
}


// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lableOfStatus.text = @"Edit-start";
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lableOfStatus.text = @"Edit-finish";
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (myCellOfStatus == cellStatusOfEdit) {
        return YES;
    }else {
        return NO;
    }
}



// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    int fromRow = sourceIndexPath.row;
    int toRow = destinationIndexPath.row;
    id myObject = [[arrOfDataSource objectAtIndex:fromRow] retain];//防止被release
    [arrOfDataSource removeObjectAtIndex:fromRow];
    [arrOfDataSource insertObject:myObject atIndex:toRow];
    [myObject release];
}

//cell - delete

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row;
    [arrOfDataSource removeObjectAtIndex:row];
    [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



#pragma mark - action - function

- (IBAction)actionMove:(id)sender {
    myCellOfStatus = cellStatusOfEdit;
    [self.myTableView setEditing:YES animated:YES];
    
}

- (IBAction)actionDelete:(id)sender {
    myCellOfStatus = cellStatusOfDelete;
    [self.myTableView setEditing:YES animated:YES];
    
}

- (IBAction)actionFinish:(id)sender {
    [self.myTableView setEditing:NO animated:YES];
    myCellOfStatus = cellStatusOfNormal;
}











@end
