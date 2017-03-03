//
//  homePageViewController.m
//  ThreadCommunicate
//
//  Created by lyl on 2017/2/21.
//  Copyright © 2017年 lyl. All rights reserved.

#import "homePageViewController.h"
#import "NSThreadCommunicateViewController.h"
#import "NSOperationQueueDependViewController.h"
#import "GCDGroupEmployViewController.h"
#import "MultithreadingViewController.h"
#import "DispatchSemaphoreViewController.h"
@interface homePageViewController ()

@end

@implementation homePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:NO andRightBtnShow:NO andTitle:@"线程间通信"];
    [self selectBtnForWhichVC:@"homePageVC"];
}

-(void)selectBtnClick:(id)sender {
    NSInteger idx = ((UIButton *)sender).tag;
    switch (idx) {
        case 0:{
            NSThreadCommunicateViewController *VC = [[NSThreadCommunicateViewController alloc] init];
            [self.navigationController pushViewController:VC animated:NO];
            break;
        }
        case 1:{
            [self createAlertView];
            break;
        }
        case 2:{
            DispatchSemaphoreViewController *VC = [[DispatchSemaphoreViewController alloc] init];
            [self.navigationController pushViewController:VC animated:NO];
            break;
        }
        case 3:{
            MultithreadingViewController *VC = [[MultithreadingViewController alloc] init];
            [self.navigationController pushViewController:VC animated:NO];
            break;
        }

        default:
            break;
    }
}

-(void)createAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查看线程依赖关系展示" message:@"please select" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"NSOperation添加单个线程依赖关系" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSOperationQueueDependViewController *VC = [[NSOperationQueueDependViewController alloc] init];
        [self.navigationController pushViewController:VC animated:NO];
        
    }];
    
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"GCD使用group监控调度一组线程" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GCDGroupEmployViewController *VC = [[GCDGroupEmployViewController alloc] init];
        [self.navigationController pushViewController:VC animated:NO];
    }];
    
    UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel");
    }];

    [alert addAction:defaultAction1];
    [alert addAction:defaultAction2];
    [alert addAction:defaultAction3];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
