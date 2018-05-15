//
//  ViewController.m
//  SMTCollectionViewDemo4
//
//  Created by Yang on 15/05/2018.
//  Copyright © 2018 SeaMoonTime. All rights reserved.
//

#import "ViewController.h"
#import "SMTPickerLayout.h"

//------------------- 获取设备大小 -------------------------
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define ROW_NUM 10

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMTPickerLayout * layout = [[SMTPickerLayout alloc]init];
    UICollectionView * collect  = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    //一开始将collectionView的偏移量设置为1屏的偏移量
    collect.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
    collect.delegate=self;
    collect.dataSource=self;
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    collect.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collect];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ROW_NUM;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 80)];
    label.text = [NSString stringWithFormat:@"我是第%ld行",(long)indexPath.row];
    [cell.contentView addSubview:label];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //小于半屏 则放到最后一屏多半屏
    if (scrollView.contentOffset.y<SCREEN_HEIGHT/2) {
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y+ROW_NUM*SCREEN_HEIGHT);
        //大于最后一屏多一屏 放回第一屏
    }else if(scrollView.contentOffset.y>(ROW_NUM+1)*SCREEN_HEIGHT){
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y-ROW_NUM*SCREEN_HEIGHT);
    }
}


@end
