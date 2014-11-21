//  ViewController.m
//  NewDeprocrastinator
//
//  Created by Albert Saucedo on 10/5/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *toDoTableView;
@property (weak, nonatomic) IBOutlet UITextField *todoTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (weak, nonatomic) NSIndexPath *indexPathToBeDeleted;
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

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {

    NSString *addedString = self.todoTextField.text;
    [self.todos addObject:addedString];
    [self.toDoTableView reloadData];
    self.todoTextField.text = @"";
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if (!self.toDoTableView.editing) {
        [sender setTitle: @"Done"];
        [self.toDoTableView setEditing:YES animated:YES];
    } else {
        [sender setTitle:@"Edit" ];
        [self.toDoTableView setEditing:NO];
    }
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

//Hide KB 2/2
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.todoTextField resignFirstResponder];
    return YES;
}

#pragma mark - tableView functions
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.todos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoCellID"];
    cell.textLabel.text = [self.todos objectAtIndex:indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    NSString *stringToMove = [self.todos objectAtIndex:sourceIndexPath.row];

    [self.todos removeObjectAtIndex:sourceIndexPath.row];
    [self.todos insertObject:stringToMove atIndex:destinationIndexPath.row];

    [self.toDoTableView reloadData];
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete Bruh";
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//Alert Before deleting 1/2
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.indexPathToBeDeleted = indexPath;

        UIAlertView *deleteAlert = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to delete it?"
                                                              message:@"This cannot be undone"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"Delete", nil];
        [deleteAlert show];
    // do not delete it here. So far the alter has not even been shown yet. It will not been shown to the user before this current method is finished.
    }
}

//Alert Before deleting 2/2

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

    if ([title isEqualToString:@"Cancel"]) {
        NSLog(@"Do not delete cell");
    } else if([title isEqualToString:@"Delete"]) {
        [self.todos removeObjectAtIndex:[self.indexPathToBeDeleted row]];
        [self.toDoTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.indexPathToBeDeleted]
                                  withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Delete Cell");

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (!self.toDoTableView.editing) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor greenColor];

    } else if (!self.toDoTableView.editing){

        //Tell which indexPath is being deleted
        self.indexPathToBeDeleted = indexPath;

        //Delete the second row
        NSLog(@"Alert!");
    }
}

#pragma mark - Helpers

-(void)DeleteAlet{

}

@end