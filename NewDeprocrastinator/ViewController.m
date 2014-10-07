//
//  ViewController.m
//  NewDeprocrastinator
//
//  Created by Albert Saucedo on 10/5/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *toDoTableView;
@property (weak, nonatomic) IBOutlet UITextField *todoTextField;
@property NSMutableArray *todos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.todos = [[NSMutableArray alloc]initWithObjects:@"One",@"Two",@"Three", @"Four", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCellID"];
    cell.textLabel.text = [self.todos objectAtIndex:indexPath.row];
    NSLog(@"%@", cell.textLabel.text);
    return cell;
}
- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {

    NSString *addedString = self.todoTextField.text;
    [self.todos addObject:addedString];
    [self.toDoTableView reloadData];
    self.todoTextField.text = @"";
}


@end
