//
//  SingleImageViewController.m
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import "SingleImageViewController.h"
#import "NetUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "BigImageView.h"

@interface SingleImageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@end

@implementation SingleImageViewCell
- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier])
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 280)];
        imageView.clipsToBounds = YES;
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:imageView];
        _customImageView = imageView;
    }
    return self;
}


@end


@interface SingleImageViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NetUtils *net;

@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger total;
@property (strong, nonatomic) NSArray *imageDataArray;

@property (assign,nonatomic) BOOL hasMore;
@property (assign,nonatomic) BOOL isLoading;
@end

@implementation SingleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSURLCache sharedURLCache].memoryCapacity = 8 * 1024 * 1024;
    [SDWebImageManager sharedManager].imageCache.maxMemoryCost = 100 * 1024 * 1024;
    [SDImageCache sharedImageCache].config.maxCacheSize = 100 * 1024 * 1024;
    
    self.hasMore = YES;
    [self.tableView registerClass:NSClassFromString(@"SingleImageViewCell") forCellReuseIdentifier:@"SingleImageCellIdentifier"];
    __weak __typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf _loadImage:@1];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SingleImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleImageCellIdentifier" forIndexPath:indexPath];
    if (!cell)
    {
        
        cell = [[SingleImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleImageCellIdentifier"];
        
    }

    [cell.customImageView sd_cancelCurrentAnimationImagesLoad];
    NSDictionary *imageDetailDic = [self.imageDataArray objectAtIndex:indexPath.row];
    [cell.customImageView sd_setImageWithURL:[NSURL URLWithString:imageDetailDic[@"url"]]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
                [strongSelf.tableView.mj_header endRefreshing];
                [strongSelf.tableView reloadData];
                strongSelf.isLoading = NO;
            });
        });
    } failure:^(NSError *error) {
        weakSelf.page --;
        [weakSelf.tableView.mj_header endRefreshing];
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
    if (scrollView == self.tableView &&
        (scrollView.contentOffset.y >= scrollView.contentSize.height - CGRectGetHeight(scrollView.frame) * 2) &&
        self.hasMore && !self.isLoading) {
        [self loadData];
    }
}

@end
