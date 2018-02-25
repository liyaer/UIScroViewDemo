//
//  ViewController.m
//  UIScroViewDemo
//
//  Created by 杜文亮 on 2018/2/25.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

/*
    contentSize是scrollView需要显示的内容大小，是一个矩形框，因为contentSize是可以滚动的，因此只有大小而没有位置，数据类型为CGSize。
    contentOffset是scrollView的contentSize的原点相对于frame原点的偏移量，是两个点之间的相对值，数据类型为CGPoint。有正负值之分。
    contentInset是scrollView的contentSize相对于自身四个边框的显示范围变化值，数据类型为UIEdgeInsets。有正负值之分，正值代表滚动范围（相比未设置contentInset时）变大，负值反之。
    注意：
        无论是否设置了有效的 contentInset（contentInset != 0），都不会影响contentSize，但是会影响contentOffset！
        如果设置了有效的contentInset，在视觉上的效果的确scrollView的可滚动范围变大（变小）了，因此contentOffset的值（主要考虑最大值、最小值这两个有意义的值）会变化（具体怎么变化依赖于上左下右参数的设置），所以计算最大、最小偏移量是需要在原来的基础上（未设置contentInset）加（contentInset是正值）减（contentInset是负值）contentInset的值。但是并不意味着contentSize属性值变化了，contentSize值保持不变。
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *scro = [[UIScrollView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 100)];
    scro.backgroundColor = [UIColor redColor];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(scro.bounds)+200, CGRectGetHeight(scro.bounds))];
    imgView.image = [UIImage imageNamed:@"1"];
    
    [scro addSubview:imgView];
    scro.contentSize = CGSizeMake(CGRectGetWidth(imgView.bounds), CGRectGetHeight(imgView.bounds));
    scro.delegate = self;
    //这里以水平方向的各种情况做演示
    //滚动范围变大，offset_x_max变大
//    scro.contentInset = UIEdgeInsetsMake(0, 0, 0, 100);
    //滚动范围变小，offset_x_max变小
//    scro.contentInset = UIEdgeInsetsMake(0, 0, 0, -100);
    //滚动范围不变，offset_x_max变小，offset_x_min变小
//    scro.contentInset = UIEdgeInsetsMake(0, 100, 0, -100);
    
    [self.view addSubview:scro];
    self.view.backgroundColor = [UIColor yellowColor];
}




#pragma mark - delegate

//用户开始手势拖拽,一次操作中仅调用一次
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"11111");
}

//滚动过程中一直回调
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //可以证明上面<注意>的说法
    NSLog(@"offset_x:%.2f ---- contentSize:%@",scrollView.contentOffset.x,NSStringFromCGSize(scrollView.contentSize));
}

//用户即将结束手势拖拽（手指离开的瞬间回调）,一次操作中仅调用一次
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //velocity（s_x,s_y）水平、竖直方向的速度，有正负之分
    //targetContentOffset（offset_x,offset_y）最终的偏移量，有正负之分。如果有需要，可以在这里提前拿到滚动的最终位置。（也就是说，在用户手指离开时就已经确定了本次滚动的最后位置，尽管当前还在滚动过程中。）
    NSLog(@"----velocity:%@----targetContentOffset:%@",NSStringFromCGPoint(velocity),NSStringFromCGPoint(*targetContentOffset));
}

//用户结束手势拖拽,一次操作中仅调用一次
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"44444");
}

//即将减速,一次操作中仅调用一次
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"55555");
}

//减速完成（通常标志着一次操作的完成）,一次操作中仅调用一次
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"66666");
}


@end
