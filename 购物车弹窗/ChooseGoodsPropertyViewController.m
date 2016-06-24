//
//  ChooseGoodsPropertyViewController.m
//  购物车弹窗
//
//  Created by 宓珂璟 on 16/6/23.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "ChooseGoodsPropertyViewController.h"
#import "ProductTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface ChooseGoodsPropertyViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger idx1;
@property (nonatomic,assign) NSInteger idx2;
@end


static NSString *identyfy1 = @"ProductTableViewCell";
static NSString *identyfy2 = @"CountTableViewCell";

@implementation ChooseGoodsPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.layer.cornerRadius = 5.0f;
    self.imageView.clipsToBounds = YES;
    [self.tableView registerNib:[UINib nibWithNibName:identyfy1 bundle:nil] forCellReuseIdentifier:identyfy1];
    [self.tableView registerNib:[UINib nibWithNibName:identyfy2 bundle:nil] forCellReuseIdentifier:identyfy2];
}



#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = nil;
    if (indexPath.row == self.dataSource.count) {
        ID = identyfy2;
    }
    else
    {
        ID = identyfy1;
    }
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self congifCell:cell indexpath:indexPath];
    return cell;
}

- (void)congifCell:(ProductTableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    if (indexpath.row < self.dataSource.count) {
        UIColor *selectedColor = [UIColor colorWithRed:255/255.0 green:174/255.0 blue:1/255.0 alpha:1];
        
        cell.leftTitleLabel.text = [self.dataSource[indexpath.row] allKeys][0];
        [cell.tagView removeAllTags];
        // 这东西非常关键
        cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 70;
        cell.tagView.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        cell.tagView.lineSpacing = 20;
        cell.tagView.interitemSpacing = 11;
        
        NSArray *arr = [self.dataSource[indexpath.row] allValues][0];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SKTag *tag = [[SKTag alloc] initWithText:arr[idx]];
            tag.font = [UIFont boldSystemFontOfSize:12];
//            tag.bgColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
//            tag.bgImg = [UIImage imageNamed:@"FE9C970DA8AD4263ABA40AFA572A0538.jpg"];
            tag.padding = UIEdgeInsetsMake(20, 20, 20, 20);
            tag.cornerRadius = 5;
            tag.borderWidth = 0;
            [cell.tagView addTag:tag];
            
            
        }];
        
        cell.tagView.didTapTagAtIndex = ^(NSUInteger idx,SKTagView *tagView)
        {
            
            ProductTableViewCell *cell = (ProductTableViewCell *)[[tagView superview] superview];
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            if (indexPath.row == 0) {
                self.idx1 = idx;
            }
            else
            {
                self.idx2 = idx;
            }
            NSLog(@"点击了第%ld行，第%ld个",indexPath.row,idx);
//            NSString *name = [self.dataSource[indexPath.row] allValues][0][idx];
            
            self.chooseLabel.text = [NSString stringWithFormat:@"%@:%@,%@:%@",[self.dataSource[0] allKeys][0],[self.dataSource[0] allValues][0][self.idx1],[self.dataSource[1] allKeys][0],[self.dataSource[1] allValues][0][self.idx2]];
//            TWTProductModelDetail *modelDetail = self.modelDetailDataSource[indexPath.row - 1];
//            for (NSInteger i = 0; i < modelDetail.values.count; i ++)
//            {
//                if (i == idx)
//                {
//                    modelDetail.selectValue = modelDetail.values[i];
//                }
//            }
//            [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSource.count) {
        return 50;
    }
    else
    {
        return [tableView fd_heightForCellWithIdentifier:identyfy1 cacheByIndexPath:indexPath configuration:^(id cell) {
           
            [self congifCell:cell indexpath:indexPath];
        }];
    }
}




- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[@{@"颜色":@[@"红色",@"蓝色",@"藏青色",@"超级无敌屎黄色",@"超级鲜艳绿油油",@"白色",@"黑色",@"图图图图图色"]},@{@"尺码":@[@"L",@"M",@"X",@"XXXL",@"XXXXXXXXL",@"超级无敌大",@"超级无敌小",@"真的小道没朋友,那你买个P啊",@"真的小道没朋友",@"真的小道没朋友",@"大到没朋友，那么胖，别买了"]}]];
    }
    return _dataSource;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
