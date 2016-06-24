//
//  ViewController.m
//  购物车弹窗
//
//  Created by 宓珂璟 on 16/6/23.
//  Copyright © 2016年 宓珂璟. All rights reserved.
//

#import "ViewController.h"
#import "KLCPopup.h"
#import "ChooseGoodsPropertyViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,strong) ChooseGoodsPropertyViewController *chooseVC;
@property (nonatomic,strong) KLCPopup *popup;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIamge:)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"哈哈" forState:UIControlStateNormal];
    [self.view addSubview:button];
    NSLog(@"%@",NSStringFromCGSize(button.intrinsicContentSize));
    
    [button setImage:[UIImage imageNamed:@"alowButton@2x"] forState:UIControlStateNormal];
//    NSLog(@"11%@",NSStringFromCGSize(button.intrinsicContentSize));
//    
//    
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
//    NSLog(@"22%@",NSStringFromCGSize(button.intrinsicContentSize));
    // 得出结论，无论你怎么搞，只要你加入了image，那么大小就固定了，你怎么移动都没用
}

- (void)clickIamge:(UITapGestureRecognizer *)tap
{
    
    if (!self.chooseVC)
    {
        self.chooseVC = [[ChooseGoodsPropertyViewController alloc] init];
    }
    

    self.chooseVC.price = 256.0f;
    
    if (!self.popup)
    {
        self.popup = [KLCPopup popupWithContentView:self.chooseVC.view
                                           showType:KLCPopupShowTypeSlideInFromBottom
                                        dismissType:KLCPopupDismissTypeSlideOutToBottom
                                           maskType:KLCPopupMaskTypeDimmed
                           dismissOnBackgroundTouch:YES
                              dismissOnContentTouch:NO];
        
    }
    [self.popup show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
