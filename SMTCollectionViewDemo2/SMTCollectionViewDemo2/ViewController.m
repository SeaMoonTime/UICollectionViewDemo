//
//  ViewController.m
//  SMTCollectionViewDemo2
//
//  Created by Yang on 14/05/2018.
//  Copyright © 2018 SeaMoonTime. All rights reserved.
//

#import "ViewController.h"
#import "SMTCollectViewLayout1.h"
#import "Cell/SMTCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SMTCollectViewLayout1 * layout = [[SMTCollectViewLayout1 alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView * collect  = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collect.delegate=self;
    collect.dataSource=self;
    
//    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
     [collect registerNib:[UINib nibWithNibName:@"SMTCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"smtcell"]; //custom cell class或xib都要注册，Storyboard不需注册
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
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SMTCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"smtcell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}


@end
