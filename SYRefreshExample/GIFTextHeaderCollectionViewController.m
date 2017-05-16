//
//  GIFTextHeaderCollectionViewController.m
//  SYRefreshExample
//
//  Created by shusy on 2017/5/15.
//  Copyright © 2017年 shusy. All rights reserved.
//

#import "GIFTextHeaderCollectionViewController.h"
#import "SYRefreshView.h"
#import "UIScrollView+SYRefresh.h"
#import "SYGifHeader.h"
#import "SYGifTextHeader.h"

@interface GIFTextHeaderCollectionViewController ()

@end

@implementation GIFTextHeaderCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSString *url =  [[NSBundle mainBundle] pathForResource:@"demo-small.gif" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:url];
    
    self.collectionView.sy_header = [SYGifTextHeader textGifheaderWithData:data orientation:SYRefreshViewOrientationLeft isBig:NO width:100 callBack:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.sy_header endRefreshing];
            NSLog(@"刷新结束");
        });
    }];
    [self.collectionView.sy_header beginRefreshing];
    
    
    self.collectionView.sy_footer = [SYGifTextHeader textGifheaderWithData:data orientation:SYRefreshViewOrientationRight isBig:NO width:100 callBack:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.sy_footer endRefreshing];
            NSLog(@"刷新结束");
        });
    }];
    
    SYTitleItem *item1 = [SYTitleItem itemWithTitle:@"滑动刷新" color:[UIColor redColor]];
    SYTitleItem *item2 = [SYTitleItem itemWithTitle:@"释放刷新" color:[UIColor greenColor]];
    SYTitleItem *item3 = [SYTitleItem itemWithTitle:@"刷新中..." color:[UIColor brownColor]];
    [self.collectionView.sy_header setHeaderForState:SYRefreshViewStateIdle item:item1];
    [self.collectionView.sy_header setHeaderForState:SYRefreshViewPulling item:item2];
    [self.collectionView.sy_header setHeaderForState:SYRefreshViewRefreshing item:item3];
    
    
    SYTitleItem *item4 = [SYTitleItem itemWithTitle:@"滑动加载" color:[UIColor redColor]];
    SYTitleItem *item5 = [SYTitleItem itemWithTitle:@"释放加载" color:[UIColor greenColor]];
    SYTitleItem *item6 = [SYTitleItem itemWithTitle:@"加载中..." color:[UIColor brownColor]];
    [self.collectionView.sy_footer setHeaderForState:SYRefreshViewStateIdle item:item4];
    [self.collectionView.sy_footer setHeaderForState:SYRefreshViewPulling item:item5];
    [self.collectionView.sy_footer setHeaderForState:SYRefreshViewRefreshing item:item6];
    
    
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor grayColor];
    return cell;
}

@end