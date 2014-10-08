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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.todos = [[NSMutableArray alloc]initWithObjects:@"One",@"Two",@"Three", @"Four", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCellID"];
    cell.textLabel.text = [self.todos objectAtIndex:indexPath.row];
    return cell;
}
- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {

    NSString *addedString = self.todoTextField.text;
    [self.todos addObject:addedString];
    [self.toDoTableView reloadData];
    self.todoTextField.text = @"";
}
- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    UIBarButtonItem *myBarButtonItem = [[UIBarButtonItem alloc] init];
    myBarButtonItem.title = @"Back"; // or whatever text you want
    self.navigationItem.backBarButtonItem = myBarButtonItem;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithRed:0.33 green:0.84 blue:0.49 alpha:1];
    NSLog(@"Selected");
}

@end
