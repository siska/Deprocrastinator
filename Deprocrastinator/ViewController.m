//
//  ViewController.m
//  Deprocrastinator
//
//  Created by S on 10/6/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSArray *toDoArray;
@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.toDoArray = [NSArray arrayWithObjects:
                      @"Finish Challenge",
                      @"Review Objective-C Book",
                      @"Walk the dog",
                      @"Play tic-tac-toe", nil];
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

- (IBAction)onAddButtonPressed:(id)sender {
    self.toDoTextField.hidden = NO;
}










@end
