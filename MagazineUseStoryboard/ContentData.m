//
//  ContentData.m
//  Magazine_V2
//
//  Created by Ken on 13-12-5.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import "ContentData.h"
#import "ASIHTTPRequest.h"
#import "GSAlert.h"
#import "MyHeader.h"
#import "zip.h"
#import "ZipArchive.h"
#import "ASINetworkQueue.h"
#import "FileOperation.h"

@implementation ContentData

-(id)init{
    self = [super init];
    if (self) {
        self.ZipURL = [[NSMutableArray alloc]init];
        self.TopicZipPath = [[NSMutableArray alloc]init];
        self.ThumbName = [[NSMutableArray alloc]init];
        self.TopicPath = [[NSMutableArray alloc]init];
        self.resourcePath = [[NSMutableArray alloc]init];
        self.ThumbPath = [[NSMutableArray alloc]init];
        self.ThumbURL = [[NSMutableArray alloc]init];
        self.ContentImagesPath = [NSMutableArray array];
        self.queue = [ASINetworkQueue queue];
    }
    return self;
}


/**
 *  description: 判断图片本地路径是否存在，不存在则下载图片
 *  @param 参数一: 图片在服务器上的URL
 *  @paran 参数二: 图片存在Documents文件夹中的路径
 */
-(void)downloadFileFrom:(NSString *)URL intoPath:(NSString * )path{
    NSURL * url = [NSURL URLWithString:URL];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setDownloadDestinationPath:path];
//    [request setCachePolicy:ASIUseDefaultCachePolicy];
    request.delegate = self;
    request.timeOutSeconds = 60;
    //支持断点续传
    [request setAllowResumeForFileDownloads:YES];

    NSLog(@"文件下载中...");
    [request startSynchronous];
    int statusCode = [request responseStatusCode];
    NSString *statusMessage = [request responseStatusMessage];
    NSLog(@"statusMessage = %@",statusMessage);
    NSLog(@"statusCode = %d",statusCode);
    switch (statusCode) {
        case 200:
            NSLog(@"文件下载成功");
            break;
        case 404:
            NSLog(@"服务器没有找到你指定的路径");
            [GSAlert showAlertWithTitle:@"文件下载失败"];
            break;
        case 500:
            NSLog(@"服务器端出错");
            [GSAlert showAlertWithTitle:@"文件下载失败"];
            break;
        default:
            break;
    }
}


-(void)downloadFileFrom:(NSString *)URLString intoPath:(NSString *)path ByCreatFolder:(NSString *)FolderName{
    //此处首先指定了图片存取路径（默认写到应用程序沙盒 中）
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //并给文件起个文件名
    //    NSString *DownloadDir = [[paths objectAtIndex:0] stringByAppendingPathComponent:FolderName];
    NSString * DownloadDir = [NSString stringWithFormat:@"%@/%@",kCachesFolderPath,FolderName];
    //创建文件夹路径
    [[NSFileManager defaultManager] createDirectoryAtPath:DownloadDir withIntermediateDirectories:YES attributes:nil error:nil];
    [self downloadFileFrom:URLString intoPath:path];
    
}
/**
 *  description:            解压文件
 *  @param 参数一:           需要解压文件的本地路径
 *  @param 参数二:           解压后存放文件的路径
 */
-(void)unzipImage:(NSString * )FileName WithZipDir:(NSString *)ZipDir{
    ZipArchive * archive = [[ZipArchive alloc]init];
    NSLog(@">>>>>>>>>>解压图片中>>>>>>>>>>>");
    BOOL result;
    
    if ([archive UnzipOpenFile:FileName]) {
        result = [archive UnzipFileTo:ZipDir overWrite:NO];
        if (!result) {
            NSLog(@"解压失败");
        }
        else
        {
            NSLog(@"解压成功");
        }
        [archive UnzipCloseFile];
    }
}


-(void)downloadByQueue{
    [self.ContentImagesPath removeAllObjects];
    for (int i = 0 ; i < self.ZipURL.count; i++) {
        NSString * ZipURL = [self.ZipURL objectAtIndex:i];
        NSString * ZipPath = [self.TopicZipPath objectAtIndex:i];
        NSString * UnZippedPath = [NSString stringWithFormat:@"%@/%@",kCachesFolderPath,self.FolderName];
        //有本地缓存就取将缓存数据放图内容视图页面
        NSString * imgName = [[ZipPath componentsSeparatedByString:@"/"]lastObject];
        imgName = [imgName stringByReplacingOccurrencesOfString:@".zip" withString:@".jpg"];
        NSString * resourcePath = [NSString stringWithFormat:@"%@/resource/%@",UnZippedPath,imgName];
        [self.ContentImagesPath addObject:resourcePath];
        //没有缓存就下载数据
        if (![FileOperation fileExistsAtPath:resourcePath]) {
            ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:ZipURL]];
            [request setDownloadDestinationPath:ZipPath];
            [request setAllowResumeForFileDownloads:YES];
            [request setDelegate:self];
            request.userInfo = @{ZipPath : UnZippedPath};
            [self.queue addOperation:request];
        }
        /*
        else{
            //有本地缓存就取将缓存数据放图内容视图页面
            NSString * imgName = [[ZipPath componentsSeparatedByString:@"/"]lastObject];
            imgName = [imgName stringByReplacingOccurrencesOfString:@".zip" withString:@".jpg"];
            NSString * resourcePath = [NSString stringWithFormat:@"%@/resource/%@",UnZippedPath,imgName];
            //            [ContentView.images addObject:[UIImage imageWithContentsOfFile:resourcePath]];
            //            [ContentView.leavesView reloadData];
            //当封面页加载完毕时需要调用NeedsDisplay方法刷新第一页
            //            if (ContentView.images.count == 1) {
            //                NSLog(@"leavesView display");
            //                [ContentView.leavesView setCurrentPageIndex:0];
            //                [ContentView.leavesView setNeedsDisplay];
        }
         */
    }
    if ([self.queue operationCount] != 0){
        [self.queue setMaxConcurrentOperationCount:5];
        [self.queue go];
    }
}

//后台继续下载目录页所需图片
-(void)downloadThumbImages{
    for (int i = 0 ; i<self.ThumbURL.count; i++) {
        NSString * ThumbURL = [self.ThumbURL objectAtIndex:i];
        NSString * ThumbPath = [self.ThumbPath objectAtIndex:i+1];//目录存放路径包含了不用下载的封面路径，所以i+1
        if (![FileOperation fileExistsAtPath:ThumbPath]) {
            [self downloadFileFrom:ThumbURL intoPath:ThumbPath];
        }
    }
}


#pragma mark - ASIHTTPRequest协议
//帮助完成后解压
- (void)requestFinished:(ASIHTTPRequest *)request
{

    NSLog(@"usrinfo = %@",request.userInfo);
    NSString * ZipPath = [[request.userInfo allKeys]objectAtIndex:0];
    NSString * UnZippedPath = [[request.userInfo allValues]objectAtIndex:0];
    //设置一次队列下载5张图片
    if ([FileOperation fileExistsAtPath:ZipPath]) {
        [self unzipImage:ZipPath WithZipDir:UnZippedPath];
        NSLog(@"Unzip complete!");
        [self deleteZipFile:ZipPath];//解压完成后删除zip文件
    }
    NSString * imgName = [[ZipPath componentsSeparatedByString:@"/"]lastObject];
    imgName = [imgName stringByReplacingOccurrencesOfString:@".zip" withString:@".jpg"];
    UnZippedPath = [NSString stringWithFormat:@"%@/resource/%@",UnZippedPath,imgName];
    [self.ContentImagesPath addObject:UnZippedPath];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"unzip" object:UnZippedPath];
}

//解压好了删除原zip文件 Caches/期刊号/zip name
- (void)deleteZipFile:(NSString *)ZipPath
{
    //下载好 存在 删除zip
    [FileOperation removeFileAtPath:ZipPath];
}


@end
