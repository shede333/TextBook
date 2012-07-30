//
//  CopyPasteTextController.m
//  TextBook
//
//  Created by shaowei on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CopyPasteTextController.h"
#import "CopyTableViewCell.h"

@implementation CopyPasteTextController
@synthesize showTextView;

@synthesize menuVisible,tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"文字复制粘贴"];
    //点击这个按钮将剪贴板的内容粘贴到title上
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] 
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                   target:self
                                   action:@selector(readFromPasteboard:)] 
                                  autorelease];
    [[self navigationItem] setRightBarButtonItem:addButton];
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"Cell";
    CopyTableViewCell *cell = (CopyTableViewCell *)[tableView 
                                                    dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[CopyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setDelegate:self];
    }
    
    // Configure the cell.
    NSString *text = [NSString stringWithFormat:@"Row %d", [indexPath row]];
    [[cell textLabel] setText:text];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isMenuVisible])
    {
        return;
    }
    [[[self tableView] cellForRowAtIndexPath:indexPath] setSelected:YES 
                                                           animated:YES];
    
    [self performSelector:@selector(showMenu:)
                          withObject:[tableView cellForRowAtIndexPath:indexPath] afterDelay:0.9f];

}
//显示菜单
- (void)showMenu:(id)cell {
    if ([cell isSelected]) {
        [cell becomeFirstResponder];
        
        UIMenuController * menu = [UIMenuController sharedMenuController];
        [menu setTargetRect: [cell frame] inView: [self tableView]];
        [menu setMenuVisible: YES animated: YES];
    }
}
- (void)readFromPasteboard:(id)sender {
    [self setTitle:[NSString stringWithFormat:@"P = %@", 
                    [[UIPasteboard generalPasteboard] string]]];
    self.showTextView.text = [[UIPasteboard generalPasteboard] string];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc{
    [tableView release];
    [showTextView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setShowTextView:nil];
    [super viewDidUnload];
    [self.tableView release];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end
