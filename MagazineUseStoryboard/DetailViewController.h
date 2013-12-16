//
//  DetailViewController.h
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-14.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic,strong) NSString * xmlPath;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)ZanBtnPressed:(UIBarButtonItem *)sender;
- (IBAction)CommentBtnPressed:(id)sender;
- (IBAction)ShareBtnPressed:(id)sender;
- (IBAction)ThumbBtnPressed:(id)sender;

@end
