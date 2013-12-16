//
//  ViewController.m
//  MagazineUseStoryboard
//
//  Created by Ken on 13-12-14.
//  Copyright (c) 2013年 Ken. All rights reserved.
//
#define NUMBER_OF_SECTION 2
#define NUMBER_OF_ROW 5
#define _BACKGROUNDQUEUE "backgroundqueue"

#import "HomeViewData.h"
#import "MyHeader.h"
#import "ViewController.h"
#import "Cell.h"
#import "SectionHeader.h"
#import "DetailViewController.h"
#import "FavouriteViewController.h"
#import "GSStoreMap.h"
#import "ASIHTTPRequest.h"
#import "GSReachability.h"
#import "FileOperation.h"

NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
NSString *kCellID = @"CellID";                          // UICollectionViewCell storyboard id
NSString * kHeaderID = @"Header";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) IBOutlet UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * cellImagesPath;
@end

@implementation ViewController
@synthesize homeViewData;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.homeViewData = [[HomeViewData alloc]init];
    self.cellImagesPath = [NSMutableArray array];
    //获取数据
    [self reloadCaches];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
-(void)reloadCaches{
    //在首页界面加载完成后，调用后台访问的代码
    //最好使用多线程，新开一个线程访问
    //新建一个后台运行的线程队列
    dispatch_async(dispatch_queue_create(_BACKGROUNDQUEUE, NULL), ^{
        [self getListXML];
        //更新好xml数据到主线程刷新table
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activity stopAnimating];
            [self.homeViewData getHomeViewDataSource];
            [self.collectionView reloadData];
        });
    });
    
}

-(void)getListXML
{
    NSLog(@"------运行到这里，说明正在网络请求后台的 List.xml --------");
    //添加网络状态判断
#warning 网络检测有改动
    if ([GSReachability checkIfOnline]) {
        //网络正常链接
        //1 得到List.xml的路径
        NSURL *listURL = [NSURL URLWithString:KListXMLDownloadURL];
        //2 建立请求对象
        ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:listURL];
        //3 设置下载的路径
        [request setDownloadDestinationPath:[FileOperation getCachesDirectory:KListXMLName]];
        //使用缓存策略
        //        [request setCachePolicy:ASIUseDefaultCachePolicy];
        //GSSaveBundleFileInDocumentsDirectory(xmlData, LISTFILENAME);  //?每次保存的都是最新的list
        //解析对应路径的 XML ，得到首页需要的数据
        [[GSStoreMap sharedInstance] getStoreMapFromXmlSource:listURL];
    }
    else
    {
        //网络不能链接
        
    }
    
}


#pragma mark - CollectionViewDataSource
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    SectionHeader * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                withReuseIdentifier:kHeaderID
                                                                       forIndexPath:indexPath];
    header.HeaderLabel.text = [homeViewData.HeaderTitle objectAtIndex:indexPath.section];
    
    return header;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    NSString * key = [homeViewData.Section objectAtIndex:indexPath.section];
    NSInteger index = indexPath.row;
    
    NSString * imagePath = [[homeViewData.PeriodicalFrontCover objectForKey:key] objectAtIndex:index];
    cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    [cell.imageView.layer setShadowColor:[UIColor whiteColor].CGColor];
    [cell.imageView.layer setShadowOffset:CGSizeMake(2, 2)];
    [cell.imageView.layer setShadowOpacity:0.5f];
    
    // make the cell's title the actual NSIndexPath value
//    cell.Label.text =[NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section];
//    NSString * str =[homeViewData.Title objectAtIndex:indexPath.row];
    NSString * str = [[homeViewData.Title objectForKey:key] objectAtIndex:indexPath.row];
    cell.Label.text = str;

    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger Row = [[homeViewData.dictData objectForKey:[homeViewData.Section objectAtIndex:section]] count];
    
    return Row;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return homeViewData.Section.count;
}

#pragma mark - StoryboardSegue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushToDetail"])
    {
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];

        // load the image, to prevent it from being cached we use 'initWithContentsOfFile'
//       DetailViewController * detailViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:kDetailedViewControllerID];
//        detailViewController = [segue destinationViewController];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        NSArray * arr =[self.homeViewData.TopicXMLPaths
                        objectForKey:[homeViewData.Section objectAtIndex:selectedIndexPath.section]];
        detailViewController.xmlPath = [arr objectAtIndex:selectedIndexPath.row];
    }else if([[segue identifier] isEqualToString:@"pushToFavourite"]){
        FavouriteViewController *favouriteViewController = [segue destinationViewController];
    }
    
}


@end
