//
//  ViewController.h
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-14.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewData;
@interface ViewController : UIViewController{
    UIActivityIndicatorView * _activity;
}
@property (nonatomic,retain)HomeViewData * homeViewData;
@end
