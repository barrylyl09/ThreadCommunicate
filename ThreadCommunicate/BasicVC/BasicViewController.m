//
//  BasicViewController.m
//
//  Created by lyl on 2017/2/19.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import "BasicViewController.h"
#import "Interface_config.h"
#import <WebKit/WebKit.h>
@interface BasicViewController ()

@end

@implementation BasicViewController
{
    BOOL     isShowHeader;
    UIView   * headerView ;
    UIButton * leftButton ;
    UIButton * rightButton ;
    NSArray  * arr;
    UIImageView *imgView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ---配置导航条/左侧按钮/右侧按钮
-(void)configShowHeaderBarOrNot:(BOOL)isShowOrNot andLeftBtnShow:(BOOL)leftShow andRightBtnShow:(BOOL)rightShow andTitle:(NSString *)title{
    isShowHeader = isShowOrNot ;
    [self.navigationController setNavigationBarHidden:YES];
    if (isShowHeader) {
        [self CommenHeaderBarWithLeftBtnShow:leftShow andRtghtBtnShow:rightShow andTitle:title];
    }
    else{
        //NSLog(@"NO HeaderBar");
    }
}

#pragma mark ---内部函数
-(void)CommenHeaderBarWithLeftBtnShow:(BOOL)isShowLeft andRtghtBtnShow:(BOOL)isShowRight andTitle:(NSString *)title
{
    headerView = [[UIView alloc] init];
    [headerView setFrame:CGRectMake(0, 0, ScreenWidth, NavBarHeight_Narmal + StatueBarHeight)];
    
    
    if (title) {
        UILabel * titleLabel = [[UILabel alloc] init];
        [titleLabel setFrame:CGRectMake(NavBarLeftBtn_Width, StatueBarHeight, ScreenWidth-2*NavBarLeftBtn_Width , NavBarHeight_Narmal)];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title ;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter ;
        [headerView addSubview:titleLabel];
    }
    
    if (isShowLeft) {
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [leftButton setFrame:CGRectMake(0, StatueBarHeight, NavBarLeftBtn_Width , NavBarHeight_Narmal)];
        
        [leftButton addTarget:self action:@selector(leftBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setBackgroundColor:[UIColor whiteColor]];
        [headerView addSubview:leftButton];
    }
    if (isShowRight) {
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [rightButton setFrame:CGRectMake(ScreenWidth - NavBarRightBtn_Width, StatueBarHeight, NavBarRightBtn_Width, 44)];
        [rightButton setBackgroundColor:[UIColor whiteColor]];
        [rightButton addTarget:self action:@selector(rightBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:rightButton];
    }
    
    [self.view addSubview:headerView];
}

#pragma mark ---leftBtn
-(void)setLeftBtnBgNormal:(UIImage *)img_nor andHighlight:(UIImage *)img_hig andTitle:(NSString *)title
{
    
    if (img_nor) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30-12,(NavBarHeight_Narmal - 22)/2.0, 12, 22)];
        [leftButton addSubview:imageView];
        [imageView setImage:img_nor];
    }
    
    if (title) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 35, NavBarHeight_Narmal)];
        [leftButton addSubview:label];
        label.text  = title;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15.0];
        
    }
}

#pragma mark ---rightBtn
-(void)setRightBtnBgNormal:(UIImage *)img_nor andHighlight:(UIImage *)img_hig andTitle:(NSString *)title
{
    if (title) {
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [rightButton setTitle:title forState:UIControlStateNormal];
        [rightButton setTitle:title forState:UIControlStateHighlighted];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    [rightButton setImage:img_nor forState:UIControlStateNormal];
    [rightButton setImage:img_hig forState:UIControlStateHighlighted];
    
}

#pragma mark ---click
-(void)leftBtnTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark ---click
-(void)rightBtnTap:(id)sender
{
    
}

#pragma mark ---loadImgView
- (UIImageView *)createImgView
{
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 300) / 2.0, 300, 300, 300)];
    imgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imgView];
    return imgView;
    
}

#pragma mark ---noticeLabel
- (UILabel *)creatLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"图片加载区域";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [imgView addSubview:label];
    return label;
}

#pragma mark ---对应控制器创建Btn
- (void)selectBtnForWhichVC:(NSString *)VC
{
    
    [self judgeVCForBtn:VC];
    
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 260) / 2.0,  topSpace + i*(space +btnHeight), 260, btnHeight)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.tag = i;
    }
}


-(void)selectBtnClick:(id)sender
{
    
}

-(NSArray *)judgeVCForBtn:(NSString *)VC
{
    if ([VC isEqualToString:@"homePageVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"NSThread展示线程通信", @"添加线程依赖关系", @"信号量控制并发数", @"iOS多线程基础使用", nil];
        return arr;
    }
    
    if ([VC isEqualToString:@"NSThreadCommunicateVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"后台加载图片", @"刷新显示图片", nil];
        return arr;
    }
    
    if ([VC isEqualToString:@"NSOperationQueueDependVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"OPS1->OPS2->OPS3", @"OPS1->OPS3->OPS2",@"OPS2->OPS1->OPS3", @"OPS2->OPS3->OPS1", @"OPS3->OPS1->OPS2", @"OPS3->OPS2->OPS1", nil];
        return arr;
    }
    
    
    if ([VC isEqualToString:@"GCDGroupEmployVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"点击显示图片",nil];
        return arr;
    }
    
    if ([VC isEqualToString:@"DispatchSemaphoreVC"]) {
        arr = [[NSArray alloc] initWithObjects:@"确认打印", nil];
        return arr;
    }
    
    return arr;
}

#pragma mark ---creatr webView
- (void)creatWebView
{
    // 1.创建webview，并设置大小
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://barryblog.farbox.com/post/iosduo-xian-cheng-xue-xi-zong-jie"]];
    // 3.加载网页
    [webView loadRequest:request];
    
    // 最后将webView添加到界面
    [self.view addSubview:webView];
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
