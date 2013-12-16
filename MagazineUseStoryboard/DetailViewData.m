//
//  DetailViewData.m
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-15.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import "DetailViewData.h"
#import "MagazineMap.h"
#import "ContentData.h"
#import "FileOperation.h"
#import "ASINetworkQueue.h"

@interface DetailViewData ()
@end

@implementation DetailViewData
@synthesize imagesArray,thumbImgArray;

-(id)init{
    if (self = [super init]) {
        imagesArray = [NSMutableArray array];
        thumbImgArray = [NSMutableArray array];
    }
    return self;
}

-(void)clearData{
    [imagesArray removeAllObjects];
    [thumbImgArray removeAllObjects];
}

-(void)getDetailViewData{
    
    [self clearData];
    NSArray * dataArray = [NSArray arrayWithArray:[MagazineMap sharedInstance].TopicArray];
    ContentData * obj = [dataArray firstObject];
    [obj downloadByQueue];
    [obj downloadThumbImages];
    [imagesArray addObjectsFromArray:obj.ContentImagesPath];
    [thumbImgArray addObjectsFromArray:obj.ThumbPath];
    
}

@end
