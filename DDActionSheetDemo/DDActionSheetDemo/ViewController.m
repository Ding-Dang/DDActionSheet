//
//  ViewController.m
//  DDActionSheetDemo
//
//  Created by DingDang on 15/6/9.
//  Copyright (c) 2015年 DingDang. All rights reserved.
//

#import "ViewController.h"
#import "DDActionSheet.h"

@interface ViewController () <DDActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Click Me" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)buttonClicked:(UIButton *)sender
{
    DDActionSheet *actionSheet = [[DDActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Button 1", @"Button 2", @"Button 3", @"Button 4"]];
    [actionSheet show];
}

#pragma mark - DDActionSheetDelegate

- (void)actionSheet:(DDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:[NSString stringWithFormat:@"Button with index %@ clicked", @(buttonIndex)] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)actionSheetCancel:(DDActionSheet *)actionSheet
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Cancel button clicked" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}


@end
