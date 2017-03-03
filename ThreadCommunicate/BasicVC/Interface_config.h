//
//  Interface_config.h
//
//  Created by lyl on 2017/2/20.
//  Copyright © 2017年 lyl. All rights reserved.
//

#ifndef Interface_config_h
#define Interface_config_h

#if TARGET_IPHONE_SIMULATOR


#elif TARGET_OS_IPHONE


#endif

#define ScreenHeight        [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth         [[UIScreen mainScreen] bounds].size.width
#define HotStatusHeight             20
#define StatueBarHeight             20
#define NavBarHeight_Narmal         44
#define NavBarHeight                64
#define TabbarHeight                49
#define NavBarLeftBtn_Width         60
#define NavBarRightBtn_Width        60
#define topSpace                    80
#define space                       8
#define imgSpace                    155
#define imgWidth                    145
#define btnHeight                   35

#endif /* Interface_config_h */
