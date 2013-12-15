//
//  FavouriteViewController.m
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-14.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import "FavouriteViewController.h"
#import "FavouriteCell.h"
@interface FavouriteViewController ()

@end

@implementation FavouriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FavouriteCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Favourite" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"png5.png"];
    return cell;
}

@end
