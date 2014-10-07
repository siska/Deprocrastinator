//
//  ViewController.m
//  Deprocrastinator
//
//  Created by S on 10/6/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ViewController.h"
#import "ToDo.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property NSMutableArray *toDos;
@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSIndexPath *indexPath;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.toDos = [[NSMutableArray alloc] init];
    NSArray *toDoTasks = [NSArray arrayWithObjects:
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

    for (NSString *task in toDoTasks)
    {
        ToDo *toDo = [[ToDo alloc] initWithTask:task priority:nil];
        [self.toDos addObject:toDo];
    }

// Modify the table view starting location instead since the textfield is the tableView header:
    //self.toDoTextField.center = CGPointMake(self.toDoTextField.center.x, self.toDoTextField.center.y-self.toDoTextField.frame.size.height);
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

- (IBAction)onSwipeGesture:(UISwipeGestureRecognizer *)sender
// For some reason swipes are also registering as selections
{
    CGPoint point = [sender locationInView:self.tableView];
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    ToDo *toDo = [self.toDos objectAtIndex:[self.tableView indexPathForCell:cell].row];

    NSArray *colorArray = [[NSArray alloc] initWithObjects:[UIColor blackColor],
                                                           [UIColor redColor],
                                                           [UIColor yellowColor],
                                                           [UIColor greenColor], nil];

    int colorInt = 100;
    for (UIColor *color in colorArray)
    {
        if (toDo.priority == color)
        {
            colorInt = (int)[colorArray indexOfObject:color];
        }
    }

    switch (colorInt) {
        case 0:
            toDo.priority = [UIColor redColor];
            break;
        case 1:
            toDo.priority = [UIColor yellowColor];
            break;
        case 2:
            toDo.priority = [UIColor greenColor];
            break;
        case 3:
            toDo.priority = [UIColor blackColor];
            break;
        default:
            NSLog(@"No matching color found in colorArray at index: %i", colorInt);
            break;
    }
    // Do I not need to reloadData?
}


#pragma mark - UITextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    ToDo *toDo = [[ToDo alloc] initWithTask:textField.text priority:nil];
    [self.toDos addObject:toDo];
    [self.tableView reloadData];
    textField.text = @"";
    [textField resignFirstResponder];
    textField.enabled = NO;

    return YES;
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        [self.toDos removeObjectAtIndex:self.indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        self.indexPath = nil;
    }
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"protoCell" forIndexPath:indexPath];
    ToDo *toDo = [self.toDos objectAtIndex:indexPath.row];

    cell.textLabel.text = toDo.task;
    cell.textLabel.textColor = toDo.priority;
    cell.accessoryType = [toDo isDone] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ToDo *toDo = [self.toDos objectAtIndex:indexPath.row];

    if (toDo.isDone)
    {
        toDo.isDone = NO;
    }
    else
    {
        toDo.isDone = YES;
    }

    [self.tableView reloadData];
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
    // Needs to be implemented but remain empty for some reason?
}

@end
