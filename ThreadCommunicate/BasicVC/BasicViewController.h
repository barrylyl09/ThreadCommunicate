//
//  BasicViewController.h
//
//  Created by lyl on 2017/2/19.
//  Copyright © 2017年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

-(void)configShowHeaderBarOrNot:(BOOL)isShowOrNot andLeftBtnShow:(BOOL)leftShow andRightBtnShow:(BOOL)rightShow andTitle:(NSString *)title;

-(void)setLeftBtnBgNormal:(UIImage *)img_nor andHighlight:(UIImage *)img_hig andTitle:(NSString *)title;

-(void)setRightBtnBgNormal:(UIImage *)img_nor andHighlight:(UIImage *)img_hig andTitle:(NSString *)title;

-(void)leftBtnTap:(id)sender;

-(void)rightBtnTap:(id)sender;

- (UILabel *)creatLabel;

- (UIImageView *)createImgView;

- (void)selectBtnForWhichVC:(NSString *)VC;

-(void)selectBtnClick:(id)sender;

- (void)creatWebView;

@end
