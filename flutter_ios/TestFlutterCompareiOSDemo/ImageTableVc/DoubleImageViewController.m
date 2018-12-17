//
//  DoubleImageViewController.m
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import "DoubleImageViewController.h"
#import "NetUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "BigImageView.h"

@interface DoubleImageViewCell : UICollectionViewCell
@property (strong,nonatomic) UIImageView *imageView;

@end

@implementation DoubleImageViewCell
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, self.bounds.size.height - 16)];
        _imageView.clipsToBounds = YES;
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_imageView];
    }
    return _imageView;
}

@end

@interface DoubleImageViewController () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (strong, nonatomic) NetUtils *net;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger total;
@property (strong, nonatomic) NSArray *imageDataArray;

@property (assign,nonatomic) BOOL hasMore;
@property (assign,nonatomic) BOOL isLoading;
@end

@implementation DoubleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasMore = YES;
    
    [NSURLCache sharedURLCache].memoryCapacity = 8 * 1024 * 1024;
    [SDWebImageManager sharedManager].imageCache.maxMemoryCost = 100 * 1024 * 1024;
    [SDImageCache sharedImageCache].config.maxCacheSize = 100 * 1024 * 1024;
    
    __weak __typeof(self)weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf _loadImage:@1];
    }];
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DoubleImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DoubleImageViewCell" forIndexPath:indexPath];
    
    [cell.imageView sd_cancelCurrentAnimationImagesLoad];
    NSDictionary *imageDetailDic = [self.imageDataArray objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageDetailDic[@"url"]]];

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageDataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *imageDetailDic = [self.imageDataArray objectAtIndex:indexPath.row];
    [BigImageView show:self.view url:imageDetailDic[@"url"]];
}

- (void)loadData
{
    if (self.page <= 0)
    {
        self.page = 0;
    }
    [self _loadImage:@(++self.page)];
}

- (void)_loadImage:(NSNumber *)page
{
    self.page = page.integerValue;
    __weak __typeof(self)weakSelf = self;
    self.isLoading = YES;
    [self.net getMethodRequestUrl:[NSString stringWithFormat:@"%@data/%@%@/%@",HOST_GANK,GANK_WELFARE,@20,page] success:^(NSDictionary *ret) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *dataRet = ret[@"results"];
            if (strongSelf.page == 1)
            {
                strongSelf.imageDataArray = dataRet;
            }
            else
            {
                NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:strongSelf.imageDataArray];
                [arr addObjectsFromArray:dataRet];
                strongSelf.imageDataArray = arr.copy;
            }
            
            strongSelf.page = page.integerValue;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.collectionView.mj_header endRefreshing];
                [strongSelf.collectionView reloadData];
                strongSelf.isLoading = NO;
            });
        });
    } failure:^(NSError *error) {
        weakSelf.page --;
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}

- (NetUtils *)net
{
    if (_net == nil)
    {
        _net = [NetUtils new];
    }
    return _net;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView &&
        (scrollView.contentOffset.y >= scrollView.contentSize.height - CGRectGetHeight(scrollView.frame) * 2) &&
        self.hasMore && !self.isLoading) {
        [self loadData];
    }
}

@end
