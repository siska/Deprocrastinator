//
//  ViewController.m
//  Deprocrastinator
//
//  Created by S on 10/6/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property NSMutableArray *toDoArray;
@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.toDoArray = [NSMutableArray arrayWithObjects:
                      @"Finish Challenge",
                      @"Review Objective-C Book",
                      @"Walk the dog",
                      @"Play tic-tac-toe", nil];

    self.toDoTextField.center = CGPointMake(self.toDoTextField.center.x, self.toDoTextField.center.y-self.toDoTextField.frame.size.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"protoCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.toDoArray objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.toDoArray addObject:self.toDoTextField.text];
    [self.tableView reloadData];
    textField.text = @"";
    [textField resignFirstResponder];
    textField.enabled = NO;

    //[self tableView:self.tableView numberOfRowsInSection:0];
    //[self tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.toDoArray.count-1 inSection:0]];

    return YES;
}

- (IBAction)onAddButtonPressed:(id)sender
{
    self.toDoTextField.enabled = YES;
    [self.toDoTextField becomeFirstResponder];
}






@end
