//
//  NSThreadCommunicateViewController.m
//  ThreadCommunicate
//
//  Created by lyl on 2017/2/21.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "NSThreadCommunicateViewController.h"

@interface NSThreadCommunicateViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel    *noticeLabel;
@end

@implementation NSThreadCommunicateViewController
{
    NSData   *tempData;
    NSString *imgUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imgUrl = @"https://img1.doubanio.com/view/photo/photo/public/p2432268969.jpg";
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"NSThread选择线程执行"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"NSThreadCommunicateVC"];
    
    _imgView = [self createImgView];
    _noticeLabel = [self creatLabel];
    
}

#pragma mark ---后台加载
- (void)loadInBack
{
    _imgView.image = nil;
    tempData = nil; //置空
    [_noticeLabel setHidden:NO];
    _noticeLabel.text = @"开始加载图片";
    [self performSelectorInBackground:@selector(loadImg:) withObject:imgUrl];
}

#pragma mark ---回主线程刷新
- (void)backToMainThread
{
    [self performSelectorOnMainThread:@selector(refreshImgView:) withObject:tempData waitUntilDone:YES];
}

- (void)loadImg:(NSString *)url
{
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    if (imgData) {
        tempData = imgData;
        //延迟线程（为了显示效果）后续demo会提到
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _noticeLabel.text = @"图片数据加载成功！";
        });
    }else{
        _noticeLabel.text = @"加载图片失败";
    }

}

- (void)refreshImgView:(NSData *)imgData {
    
    if (imgData) {
        UIImage *image = [UIImage imageWithData:imgData];
        [_noticeLabel setHidden:YES];
        [_imgView setImage:image];
    }else{
        _noticeLabel.text = @"加载图片失败";
    }
}

- (void)selectBtnClick:(id)sender {
    NSInteger idx = ((UIButton *)sender).tag;
    switch (idx) {
        case 0:{
            [self loadInBack];
            break;
        }
        case 1:{
            [self backToMainThread];
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
