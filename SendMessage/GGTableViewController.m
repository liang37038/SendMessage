//
//  GGTableViewController.m
//  SendMessage
//
//  Created by Richard Liang on 16/3/16.
//  Copyright © 2016年 lwj. All rights reserved.
//

#import "GGTableViewController.h"
#import "MessageView.h"

@interface GGTableViewController ()

@property (strong, nonatomic) MessageView *messageView;

@end

@implementation GGTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ggcell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect cellRectFromWindow = [tableView convertRect:selectedCell.frame toView:[UIApplication sharedApplication].keyWindow];
    [MessageView showInScrollView:tableView belowCellRect:cellRectFromWindow];
}

@end
