//
//  HomeViewData.m
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-15.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import "HomeViewData.h"
#import "GSStoreMap.h"
#import "PeriodicalData.h"
#import "MyHeader.h"
#import "FileOperation.h"
@implementation HomeViewData
@synthesize Section,PeriodicalThumb,Title,dictData,HeaderTitle;

-(id)init{
    if (self = [super init]) {
        Section = [NSMutableArray array];
        PeriodicalThumb = [NSMutableArray array];
        Title = [NSMutableArray array];
        dictData = [NSMutableDictionary dictionary];
        HeaderTitle = [NSMutableArray array];
    }
    return self;
}

-(void)getHomeViewDataSource{
    [self clearData];
    dictData = [NSMutableDictionary dictionaryWithDictionary:[GSStoreMap sharedInstance].yearData];
    NSArray * array = [NSMutableArray arrayWithArray:[[dictData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    for (NSString * obj in [array reverseObjectEnumerator]) {
        [Section addObject:obj];
        [HeaderTitle addObject:[obj stringByAppendingString:@"年"]];
    }
    
    [self sortMonthData];
    //下载封面图及内容页xml
    for (int i = 0 ; i<Section.count; i++) {
        for (int j = 0; j< [[dictData objectForKey:[Section objectAtIndex:i]] count]; j++) {
            PeriodicalData * pData = [[dictData objectForKey:[Section objectAtIndex:i]] objectAtIndex:j];
            NSString * DownloadDir = [NSString stringWithFormat:@"%@/%@",kCachesFolderPath,pData.FolderName];
            //创建文件夹路径
            [[NSFileManager defaultManager] createDirectoryAtPath:DownloadDir withIntermediateDirectories:YES attributes:nil error:nil];
            [Title addObject:pData.LabelTitle];
            NSString * str = [NSString stringWithFormat:@"%@/%@/%@",kCachesFolderPath,pData.FolderName,pData.FrontCoverName];
            [PeriodicalThumb addObject:str];
            if (![FileOperation fileExistsAtPath:[PeriodicalThumb objectAtIndex:j]]) {
                [pData downloadFileFrom:pData.FrontCoverURL intoPath:[PeriodicalThumb objectAtIndex:j]];
                [pData downloadFileFrom:pData.TopicXMLURL intoPath:[NSString stringWithFormat:@"%@/%@/%@.xml",kCachesFolderPath,pData.FolderName,pData.FolderName]];
            }
        }
    }
}



-(void)clearData{
    if (dictData) {
        [Section removeAllObjects];
        [PeriodicalThumb removeAllObjects];
        [Title removeAllObjects];
        [dictData removeAllObjects];
        [HeaderTitle removeAllObjects];
    }
    
}

-(void)sortMonthData{
    for (int i = 0; i<Section.count; i++) {
        NSString * key = [Section objectAtIndex:i];
        NSArray * arr =[dictData objectForKey:key];
        NSMutableArray * obj = [NSMutableArray arrayWithArray:arr];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"PeriodicalTag" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
        [obj sortUsingDescriptors:sortDescriptors];
        [dictData removeObjectForKey:key];
        [dictData setObject:obj forKey:key];
    }
    
}

@end
