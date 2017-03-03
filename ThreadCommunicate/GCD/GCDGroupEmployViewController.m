//
//  GCDGroupEmployViewController.m
//  ThreadCommunicate
//
//  Created by lyl on 2017/2/21.
//  Copyright © 2017年 lyl. All rights reserved.
//


#import "GCDGroupEmployViewController.h"
#import "Interface_config.h"

@interface GCDGroupEmployViewController ()

@property (nonatomic, strong) UIImageView *imgView1;
@property (nonatomic, strong) UIImageView *imgView2;
@end

@implementation GCDGroupEmployViewController
{
    NSString *imgUrl1;
    NSString *imgUrl2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imgUrl1 = @"https://img1.doubanio.com/view/photo/photo/public/p2432682167.jpg";
    imgUrl2 = @"https://img3.doubanio.com/view/photo/photo/public/p2432698525.jpg";
    
    [super configShowHeaderBarOrNot:YES andLeftBtnShow:YES andRightBtnShow:NO andTitle:@"GCD-group的使用"];
    [super setLeftBtnBgNormal:nil andHighlight:nil andTitle:@"Back"];
    
    [self selectBtnForWhichVC:@"GCDGroupEmployVC"];
    
    _imgView1 = [self createImgView];
    _imgView2 = [self createImgView];
    _imgView1.frame = CGRectMake((ScreenWidth - 300) / 2.0, 300, imgWidth, 300);
    _imgView2.frame = CGRectMake((ScreenWidth - 300) / 2.0 + imgSpace, 300, imgWidth, 300);
}

- (void)selectBtnClick:(id)sender {
    
            [self loadPicture];
}

#pragma mark ---dispatch_group使用
- (void)loadPicture
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_async(queue, ^{
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_t group2 = dispatch_group_create();
        
        __block UIImage *img1 = nil;
        __block UIImage *img2 = nil;
        
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            img1 = [self loadImg:imgUrl1];
            NSString *str1 = [self getCurrentTime];
            NSLog(@"图片1加载时间:%@\n",str1);
        });
        
        dispatch_group_async(group2, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            img2 = [self loadImg:imgUrl2];
            NSString *str2 = [self getCurrentTime];
            NSLog(@"图片2加载时间:%@\n",str2);
        });
        
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            _imgView1.image = img1;
            
        });
        
        dispatch_group_notify(group2, dispatch_get_main_queue(), ^{
            _imgView2.image = img2;
        });
    });

}

-(UIImage *)loadImg:(NSString *)url
{
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    UIImage *img = [UIImage imageWithData:imgData];
    
    if (!imgData) NSLog(@"无法获取图片数据");
    
    return img;
    
}

#pragma mark ---获取时间
- (NSString *)getCurrentTime
{
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    
    [forMatter setDateFormat:@"HH-mm-ss yyyy-MM-dd"];
    
    NSString *dateStr = [forMatter stringFromDate:date];
    
    return dateStr;
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
