//
//  ViewController.m
//  SMTCollectionViewDemo5
//
//  Created by Yang on 15/05/2018.
//  Copyright © 2018 SeaMoonTime. All rights reserved.
//

#import "ViewController.h"
#import "SMTSphereLayout.h"

//------------------- 获取设备大小 -------------------------
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SMTSphereLayout * layout = [[SMTSphereLayout alloc]init];
    UICollectionView * collect  = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collect.delegate=self;
    collect.dataSource=self;
    //这里设置的偏移量是为了无缝进行循环的滚动，具体在上一篇博客中有解释
    collect.contentOffset = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:collect];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//我们返回30的标签
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [cell.contentView addSubview:label];
    return cell;
}

//这里对滑动的contentOffset进行监控，实现循环滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //X方向
    //小于半屏 则放到最后一屏多半屏
    if (scrollView.contentOffset.y<SCREEN_HEIGHT/2) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+10*SCREEN_HEIGHT);
        //大于最后一屏多一屏 放回第一屏
    }else if(scrollView.contentOffset.y>11*SCREEN_HEIGHT){
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-10*SCREEN_HEIGHT);
    }
    //Y方向
    if (scrollView.contentOffset.x<SCREEN_WIDTH/2) {
        //小于半屏 则放到最后一屏多半屏
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x+10*SCREEN_WIDTH,scrollView.contentOffset.y);
        //大于最后一屏多一屏 放回第一屏
    }else if(scrollView.contentOffset.x>11*SCREEN_WIDTH){
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x-10*SCREEN_WIDTH,scrollView.contentOffset.y);
    }
}


@end
