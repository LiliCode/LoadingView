//
//  TableViewController.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/19.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "TableViewController.h"
#import "LinRefreshHeader.h"
#import "LinRefreshFooter.h"

#import "MBProgressHUD+Loading.h"
#import "UIViewController+Loading.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"自定义刷新";
    
    self.tableView.mj_header = [LinRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            MJRefreshLog(@"刷新完成");
        });
    }];
    
    self.tableView.mj_footer = [LinRefreshFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
            MJRefreshLog(@"加载完成");
        });
    }];
    
    
//    [MBProgressHUD showLoadingAddedTo:self.tableView];
    
    self.loading_textColor = [UIColor grayColor];
    [self showStatusText:@"获取订单信息失败，请点击屏幕刷新..." loadingStyle:LoadingIndicatorStyleAnnulus click:^(UILabel *label, LoadDataStatus status) {
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (IBAction)toast:(UIBarButtonItem *)sender
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    [MBProgressHUD showText:@"测试Toast是否可以使用" afterDelay:2];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据-%lu", indexPath.row];
    
    return cell;
}




@end




