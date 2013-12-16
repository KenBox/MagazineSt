//
//  DetailViewController.m
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-14.
//  Copyright (c) 2013年 Ken. All rights reserved.
//

#import "DetailViewController.h"
#import "ThumbViewController.h"
#import "DetailViewData.h"
#import "MagazineMap.h"
#import "UIView+SubviewTraversal.h"
#import "DetailCollectionCell.h"

@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIToolbar *Toolbar;
@property (nonatomic,strong) DetailViewData * detailViewData;
@property (nonatomic,strong) NSMutableArray * thumbImagePaths;
- (IBAction)TapGesture:(id)sender;
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
        _thumbImagePaths = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.detailViewData = [[DetailViewData alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    dispatch_async(dispatch_queue_create("backgroundqueue", NULL), ^{
        [[MagazineMap sharedInstance]getMagazineMapFromXmlSource:_xmlPath];
        [self.detailViewData getDetailViewData];
        [self.collectionView reloadData];
    });
}

-(void)viewDidLayoutSubviews{
//    [self.view.window printSubviews];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ZanBtnPressed:(UIBarButtonItem *)sender {
    
}
-(void)CommentBtnPressed:(id)sender{
    
}
-(void)ShareBtnPressed:(id)sender{
    
}
-(void)ThumbBtnPressed:(id)sender{
//    ThumbViewController * thumbViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ThumbView"];
//    [self presentViewController:thumbViewController animated:YES completion:^(){
//    
//    }];
    
}
- (IBAction)TapGesture:(id)sender {
    
    NSLog(@"tap");
//    CATransition *trans=[CATransition animation];
//    trans.type=kCATransitionPush;
//    trans.duration=0.2f;
    
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        trans.subtype=kCATransitionFromTop;
//       [self.Toolbar.layer addAnimation:trans forKey:@"transition"];
//        [self.Toolbar setHidden:NO];
    }else if (!self.navigationController.navigationBarHidden){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        trans.subtype=kCATransitionFromBottom;
//        [self.Toolbar.layer addAnimation:trans forKey:@"transition"];
//        [self.Toolbar setHidden:YES];
    }
}

#pragma mark - CollectionViewDataSource
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:{
//    
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
    NSString * imgPath = [self.detailViewData.imagesArray objectAtIndex:indexPath.row];
    UIImage * img = [UIImage imageWithContentsOfFile:imgPath];
    cell.imageView.image = img;

    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.detailViewData.imagesArray.count;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



@end


