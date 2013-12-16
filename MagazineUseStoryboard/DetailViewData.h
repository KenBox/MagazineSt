//
//  DetailViewData.h
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-15.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailViewData : NSObject
@property (nonatomic,strong,readonly)NSMutableArray * imagesArray;
@property (nonatomic,strong,readonly)NSMutableArray * thumbImgArray;
-(void)getDetailViewData;
@end
