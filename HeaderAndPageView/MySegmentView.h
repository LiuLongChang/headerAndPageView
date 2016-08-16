//
//  MySegmentView.h
//  HeaderAndPageView
//
//  Created by langyue on 16/8/16.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySegmentView : UIView<UIScrollViewDelegate>



@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,strong)NSArray * controllers;
@property(nonatomic,strong)UIView * segmentView;
@property(nonatomic,strong)UIScrollView * segmentScrollV;
@property(nonatomic,strong)UILabel * line;
@property(nonatomic,strong)UIButton * seleBtn;
@property(nonatomic,strong)UILabel * down;


-(instancetype)initWithFrame:(CGRect)frame controllers:(NSArray*)controllers titleArray:(NSArray*)titleArray parentController:(UIViewController*)parentC lineWidth:(float)lineW lineHeight:(float)lineH;


@end
