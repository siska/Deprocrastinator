//
//  ViewController.m
//  Deprocrastinator
//
//  Created by S on 10/6/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>
@property NSMutableArray *toDoArray;
@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *selectedCells;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.toDoArray = [NSMutableArray arrayWithObjects:
                      @"Finish Challenge",
                      @"Review Objective-C Book",
                      @"Walk the dog",
                      @"Play tic-tac-toe",
                      @"5",
                      @"6",
                      @"7",
                      @"8",
                      @"9",
                      @"10",
                      @"11",
                      @"12",
                      @"13",
                      @"14",
                      @"15",
                      @"16",
                      @"17",
                      @"18",
                      @"19",
                      @"20", nil];
    // New Stuff:
    self.selectedCells = [NSMutableArray array];

    self.toDoTextField.center = CGPointMake(self.toDoTextField.center.x, self.toDoTextField.center.y-self.toDoTextField.frame.size.height);
}

- (IBAction)onAddButtonPressed:(id)sender
{
    self.toDoTextField.enabled = YES;
    [self.toDoTextField becomeFirstResponder];
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender
{
    if ([self.tableView isEditing])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(onEditButtonPressed:)];

        [self.tableView setEditing: NO animated: YES];

    }
    else if (![self.tableView isEditing])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onEditButtonPressed:)];

        [self.tableView setEditing:YES animated:YES];
    }
}

- (IBAction)onSwipeGesture:(UISwipeGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.tableView];
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];

    NSArray *colorArray = [[NSArray alloc] initWithObjects:[UIColor blackColor], [UIColor redColor], [UIColor yellowColor], [UIColor greenColor], nil];

    int colorInt = 100;
    for (UIColor *color in colorArray)
    {
        if (cell.textLabel.textColor == color)
        {
            colorInt = (int)[colorArray indexOfObject:color];
        }
    }

    switch (colorInt) {
        case 0:
            cell.textLabel.textColor = [UIColor redColor];
            break;
        case 1:
            cell.textLabel.textColor = [UIColor yellowColor];
            break;
        case 2:
            cell.textLabel.textColor = [UIColor greenColor];
            break;
        case 3:
            cell.textLabel.textColor = [UIColor blackColor];
            break;
        default:
            NSLog(@"No matching color found in colorArray at index: %i", colorInt);
            break;
    }

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        [self.toDoArray removeObjectAtIndex:self.indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        self.indexPath = nil;
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"protoCell" forIndexPath:indexPath];
    //New stuff:
    cell.accessoryType = ([self isRowSelectedOnTableView:tableView atIndexPath:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    cell.textLabel.text = [self.toDoArray objectAtIndex:indexPath.row];
    return cell;
}
// New Stuff:
-(BOOL)isRowSelectedOnTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return ([self.selectedCells containsObject:indexPath]) ? YES : NO;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.toDoArray addObject:self.toDoTextField.text];
    [self.tableView reloadData];
    textField.text = @"";
    [textField resignFirstResponder];
    textField.enabled = NO;

    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
// Add functionality to uncheck an item
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // New Stuff:
    if([self isRowSelectedOnTableView:tableView atIndexPath:indexPath]){
        [self.selectedCells removeObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.selectedCells addObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    //Old Stuff:
//    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    else if (cell.accessoryType == UITableViewCellAccessoryNone)
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        [alert show];

        self.indexPath = indexPath;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{

}


@end
