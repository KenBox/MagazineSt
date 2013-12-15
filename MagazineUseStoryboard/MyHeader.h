//
//  MyHeader.h
//  Magazine_V2
//
//  Created by Ken on 13-12-14.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#ifndef Magazine_V2_MyHeader_h
#define Magazine_V2_MyHeader_h

//--------------------------------文件存放路径--------------------------

//公网上的服务器，有网络，真机时使用
//#define kBaseHttpURL @"http://218.4.19.242:8089"
//陈健公网服务器地址
//#define kBaseHttpURL @"http://42.121.0.245:8080"
//本地电脑上的服务器，无网络，模拟器时使用
#define kBaseHttpURL @"http://localhost:8080"

//项目名称和项目中存放 数据的目录
#define kResouceFlieName @"naill/upload"
//项目中总的配置文件名称 List.xml
#define KListXMLName @"List.xml"

//程序总的 List.xml
//http://localhost:8080/naill/upload/List.xml
#define KListXMLDownloadURL [NSString stringWithFormat:@"%@/%@/%@",kBaseHttpURL,kResouceFlieName,KListXMLName]


#define kCachesFolderPath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"] //Caches文件夹
#define KDocumentFolderPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] //Documents文件夹
#define kTmpFolderPath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/Tmp"] //tmp文件夹
#define kResouceUseFolderPath [kCachesFolderPath stringByAppendingPathComponent:kResouceFlieName] //资源使用目录 Library/Caches/jianfengzazhi
#define kResouceDownloadFolderPath [kTmpFolderPath stringByAppendingPathComponent:kResouceFlieName]	//资源临时存放目录
#define kResouceDownloadURL [NSString stringWithFormat:@"%@/%@", kBaseHttpURL, kResouceFlieName]



#define KLoadingImageDownloadURL [NSString stringWithFormat:@"%@/%@/%@",kBaseHttpURL,KLoadingFileName,KLoadingImageName] //http://mz.glavesoft.com/WelcomeImages_magazine/loading_bg.png
//[kBaseHttpURL stringByAppendingPathComponent:kResouceFlieName]	//用这种方式http：//会变成http：/


//sina weibo key
#define kAppKey             @"2527883662"
#define kAppSecret          @"d6e639fba11bb9097cfe50d787997515"
#define kAppRedirectURI     @"http://www.sina.com"

#ifndef __OPTIMIZE__
#    define NSLog(...) NSLog(__VA_ARGS__)
#else
#    define NSLog(...) {}
#endif


#warning
#define NEED_OUTPUT_LOG                     0

#define USER_DEFAULT                [NSUserDefaults standardUserDefaults]

#define APP_CACHES_PATH             [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define APP_SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

#define APP_SCREEN_CONTENT_HEIGHT   ([UIScreen mainScreen].bounds.size.height-20.0)

#define IS_4_INCH                   (APP_SCREEN_HEIGHT > 480.0)

#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//#define APP_STORE_LINK_http                 @"https://itunes.apple.com/cn/app/dou-ban-xiang-ce-jing-xuan-ji/id588070942?ls=1&mt=8"
//#define APP_STORE_LINK_iTunes               @"itms-apps://itunes.apple.com/cn/app/id588070942?mt=8"
//
//#define APP_COMMENT_LINK_iTunes             @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=588070942"

//#define IMAGE_CACHE     [SDImageCache sharedImageCache]
#define NOTIFICATION_CENTER         [NSNotificationCenter defaultCenter]


#endif
