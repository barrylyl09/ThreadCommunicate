//
//  DispatchSemaphoreViewController.m
//  ThreadCommunicate
//
//  Created by lyl on 2017/2/21.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "DispatchSemaphoreViewController.h"

@interface DispatchSemaphoreViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel    *noticeLabel;

@end

@implementation DispatchSemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"信号量打印测试"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"DispatchSemaphoreVC"];
    
    _imgView = [self createImgView];
    _noticeLabel = [self creatLabel];
    _noticeLabel.text = @"查看打印顺序，学习信号量用法";
    
}

-(void)selectBtnClick:(id)sender
{
    [self testSemaphore];
}

#pragma mark ---信号量 (1-4-2-5-3-6)
- (void)testSemaphore
{
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);//创建一个为1信号量的信号
    
    __block NSInteger seamphoreNUM = 0 ;
    
    NSLog(@"信号量1：%ld",seamphoreNUM);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSThread sleepForTimeInterval:1];
        seamphoreNUM = dispatch_semaphore_signal(signal);
        NSLog(@"信号量2：%ld",seamphoreNUM);
        
        [NSThread sleepForTimeInterval:1];
        seamphoreNUM = dispatch_semaphore_signal(signal);
        NSLog(@"信号量3：%ld",seamphoreNUM);
        
        [NSThread sleepForTimeInterval:1];
        seamphoreNUM = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        NSLog(@"信号量7：%ld",seamphoreNUM);
        
    });
    
    seamphoreNUM = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"信号量4：%ld",seamphoreNUM);
    
    seamphoreNUM = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"信号量5：%ld",seamphoreNUM);
    
    seamphoreNUM = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    
    NSLog(@"信号量6：%ld",seamphoreNUM);
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
