//
//  NewsViewController.m
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import "NewsViewController.h"
#import "NetUtils.h"
#import "WKWebViewController.h"

typedef enum : NSUInteger {
    NewsWAN_WxArticle,
    News_WxArticle_list,
} News_RequestType;
@interface NewsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger total;
@property (strong, nonatomic) NetUtils *net;

@property (assign, nonatomic) News_RequestType requestType;
@property (assign,nonatomic) BOOL hasMore;
@property (assign,nonatomic) BOOL isLoading;

@property (assign, nonatomic) NSNumber *currentCharpterId;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self loadData];
    self.hasMore = NO;
    self.isLoading = NO;
    
}

- (void)loadData
{
    if (self.requestType == NewsWAN_WxArticle)
        [self _loadTreeData];
    else
        [self _loadChapter:@1 chapterId:_currentCharpterId];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellIdentifier" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewsCellIdentifier"];
    }
    
    
    NSDictionary *articleDic = [self.articleTitleArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (_requestType == NewsWAN_WxArticle)
        cell.textLabel.text = articleDic[@"name"];
    else
        cell.textLabel.text = articleDic[@"title"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleTitleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_requestType == NewsWAN_WxArticle)
    {
        id chapterId = [self.articleTitleArray objectAtIndex:indexPath.row][@"id"];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        NewsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"NewsViewController"];
        [vc _loadChapter:@1 chapterId:chapterId];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (_requestType == News_WxArticle_list)
    {
        NSString *link = [self.articleTitleArray objectAtIndex:indexPath.row][@"link"];
        WKWebViewController *wk = [[WKWebViewController alloc] init];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:link]];
        [wk.wkwebView loadRequest:request];
        [self.navigationController pushViewController:wk animated:YES];
    }
    
}



- (void)_loadTreeData
{
    _requestType = NewsWAN_WxArticle;
    self.hasMore = NO;
    __weak __typeof(self)weakSelf = self;
    self.page = 1;
    self.isLoading = YES;
    [self.net getMethodRequestUrl:[NSString stringWithFormat:@"%@%@",HOST_URL,WAN_WXARTICLE] success:^(NSDictionary *ret) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            strongSelf.articleTitleArray = ret[@"data"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
                strongSelf.isLoading = NO;
            });
        });
        
    } failure:^(NSError *error) {
        weakSelf.page --;
        weakSelf.isLoading = NO;
    }];
}

- (void)_loadChapter:(NSNumber *)page chapterId:(NSNumber *)chapterId
{
    _currentCharpterId = chapterId;
    _requestType = News_WxArticle_list;
    self.isLoading = YES;
    __weak __typeof(self)weakSelf = self;
    [self.net getMethodRequestUrl:[NSString stringWithFormat:@"%@%@/%@/%@/json",HOST_URL,WAN_WXARTICLE_LIST,chapterId,page] success:^(NSDictionary *ret) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *dataRet = ret[@"data"];
            
            
            if (page.integerValue == 1)
            {
                strongSelf.articleTitleArray = dataRet[@"datas"];
            }
            else
            {
                NSMutableArray *arr = [NSMutableArray arrayWithArray:strongSelf.articleTitleArray];
                [arr addObjectsFromArray:dataRet[@"datas"]];
                strongSelf.articleTitleArray = arr.copy;
            }
            
            strongSelf.page = [dataRet[@"curPage"] integerValue];
            strongSelf.total = [dataRet[@"pageCount"] integerValue];
            if (strongSelf.page >= strongSelf.total)
            {
                strongSelf.hasMore = NO;
            }
            else
            {
                strongSelf.hasMore = YES;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
                strongSelf.isLoading = NO;
            });
        });
        
    } failure:^(NSError *error) {
        weakSelf.page --;
        weakSelf.isLoading = NO;
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


- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    UIEdgeInsets insets = self.view.safeAreaInsets;
    [self.tableView setFrame:CGRectMake(0, insets.top + self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height + insets.bottom)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tableView &&
        (scrollView.contentOffset.y >= scrollView.contentSize.height - CGRectGetHeight(scrollView.frame) * 2) &&
        self.hasMore && self.requestType == News_WxArticle_list && !self.isLoading) {
        [self _loadChapter:@(++self.page) chapterId:_currentCharpterId];
    }
}

@end
