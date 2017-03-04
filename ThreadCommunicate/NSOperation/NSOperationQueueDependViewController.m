//
//  NSOperationQueueDependViewController.m
//  ThreadCommunicate
//
//  Created by lyl on 2017/2/21.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "NSOperationQueueDependViewController.h"
#import "Interface_config.h"

@interface NSOperationQueueDependViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel    *noticeLabel;


@end

@implementation NSOperationQueueDependViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"NSO添加线程依赖关系"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"NSOperationQueueDependVC"];
    
    _imgView = [self createImgView];
    _imgView.frame = CGRectMake((ScreenWidth - 300) / 2.0, 340, 300, 240);
    _noticeLabel = [self creatLabel];
    _noticeLabel.text = @"观察执行顺序：\n";
}

/*
 *这里遇到一个非常好玩的事，按序执行完线程，刷新UI的显示特别缓慢 （如果把刷新UI放在BLock外，就会出现BUG）
 */
- (void)operationThreadDepend:(NSInteger )sequenceIdx {
    
    _noticeLabel.text = nil;
    
    NSMutableString * processStr = [[NSMutableString alloc] init];
    [processStr appendString:@"观察执行顺序：\n"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        
        [processStr appendString:@"执行NO.1操作\n"];

    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){
        
        [processStr appendString:@"执行NO.2操作\n"];
        
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^(){
        
        [processStr appendString:@"执行NO.3操作\n"];
        
    }];
    
    NSBlockOperation *mainOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _noticeLabel.text = processStr;
        }];
    }];
    
    
    switch (sequenceIdx) {
        case 123:{
            [operation3 addDependency:operation2];
            [operation2 addDependency:operation1];
            [mainOperation addDependency:operation3];
            break;
        }
        case 132:{
            [operation2 addDependency:operation3];
            [operation3 addDependency:operation1];
            [mainOperation addDependency:operation2];
            break;
        }
        case 213:{
            [operation3 addDependency:operation1];
            [operation1 addDependency:operation2];
            [mainOperation addDependency:operation3];
            break;
        }
        case 231:{
            [operation1 addDependency:operation3];
            [operation3 addDependency:operation2];
            [mainOperation addDependency:operation1];
            break;
        }
        case 312:{
            [operation2 addDependency:operation1];
            [operation1 addDependency:operation3];
            [mainOperation addDependency:operation2];
            break;
        }
        case 321:{
            [operation1 addDependency:operation2];
            [operation2 addDependency:operation3];
            [mainOperation addDependency:operation1];
            break;
        }
            
        default:
            break;
    }
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    [queue addOperation:mainOperation];
    
}

- (void)selectBtnClick:(id)sender {
    NSInteger idx = ((UIButton *)sender).tag;
    switch (idx) {
        case 0:{
            [self operationThreadDepend:123];
            break;
        }
        case 1:{
            [self operationThreadDepend:132];
            break;
        }
        case 2:{
            [self operationThreadDepend:213];
            break;
        }
        case 3:{
            [self operationThreadDepend:231];
            break;
        }
        case 4:{
            [self operationThreadDepend:312];
            break;
        }
        case 5:{
            [self operationThreadDepend:321];
            break;
        }
        default:
            break;
    }
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
