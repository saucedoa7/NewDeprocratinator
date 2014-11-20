//  ViewController.m
//  NewDeprocrastinator
//
//  Created by Albert Saucedo on 10/5/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *toDoTableView;
@property (weak, nonatomic) IBOutlet UITextField *todoTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property NSMutableArray *todos;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoTableView.backgroundColor = [UIColor colorWithRed:0.25 green:0.6 blue:0.38 alpha:1];
    self.todos = [[NSMutableArray alloc]initWithObjects:@"One",@"Two",@"Three", @"Four", nil];
    //Hide KB 1/2
    self.todoTextField.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCellID"];
    cell.textLabel.text = [self.todos objectAtIndex:indexPath.row];

    return cell;
}

- (IBAction)onSwipe:(UISwipeGestureRecognizer *)sender {
    //Get indexPath where you swipe

    NSIndexPath *indexPath = [self.toDoTableView indexPathForRowAtPoint:[sender locationInView:self.toDoTableView]];
    UITableViewCell *cell = [self.toDoTableView cellForRowAtIndexPath:indexPath];

    if (!self.toDoTableView.editing) {
        if ([cell.textLabel.textColor  isEqual:[UIColor blackColor]]) {
            cell.textLabel.textColor = [UIColor greenColor];
        } else if ([cell.textLabel.textColor isEqual:[UIColor greenColor]]) {
            cell.textLabel.textColor = [UIColor yellowColor];
        } else if ([cell.textLabel.textColor isEqual:[UIColor yellowColor]]) {
            cell.textLabel.textColor = [UIColor redColor];
        } else if ([cell.textLabel.textColor isEqual:[UIColor redColor] ]) {
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
}


- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {

    NSString *addedString = self.todoTextField.text;
    [self.todos addObject:addedString];
    [self.toDoTableView reloadData];
    self.todoTextField.text = @"";
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if (self.toDoTableView.editing) {
        sender.title = @"Done";
        [self.toDoTableView setEditing:YES animated:YES];
    } else {
        sender.title = @"Edit";
        self.editing = NO;
        [self.toDoTableView setEditing:NO];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete Bruh";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todos removeObjectAtIndex:indexPath.row];
        [self.toDoTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.toDoTableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if ([self.editButton.title isEqualToString:@"Done"]) {
        [self.todos removeObjectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        [self.toDoTableView reloadData];
    } else if ([self.editButton.title isEqualToString:@"Edit"]){
        cell.textLabel.textColor = [UIColor blackColor];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{


    NSMutableArray *originArray = [self.todos objectAtIndex:sourceIndexPath.section];
    NSMutableArray *destinyArray = [self.todos objectAtIndex:destinationIndexPath.section];

    [destinyArray addObject:[originArray objectAtIndex:sourceIndexPath.row]];
    [originArray removeObjectAtIndex:sourceIndexPath.row];
    [self.toDoTableView reloadData];
}

//Hide KB 2/2
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.todoTextField resignFirstResponder];
    return YES;
}

#pragma mark - Swipe Right function

/*
 -(void)screenWasSwiped:(NSIndexPath *)indexPath{
 NSLog(@"Swiped!");
 self.lblChangeColor.textColor = [UIColor colorWithRed:0.97 green:0 blue:0.27 alpha:1];
 
 }
 */
@end