//
//  HomeViewData.h
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-15.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewData : NSObject{

}

@property (nonatomic,strong,readonly)NSMutableArray * Section;
@property (nonatomic,strong,readonly)NSMutableArray * HeaderTitle;
@property (nonatomic,strong,readonly)NSMutableArray * PeriodicalThumb;
@property (nonatomic,strong,readonly)NSMutableDictionary * dictData;
@property (nonatomic,strong,readonly)NSMutableArray * Title;

-(void)getHomeViewDataSource;

@end
