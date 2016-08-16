//
//  MySegmentView.m
//  HeaderAndPageView
//
//  Created by langyue on 16/8/16.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "MySegmentView.h"


@interface MySegmentView()
{

    CGPoint frameT;

    CGFloat historyX;


}

@end

@implementation MySegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(instancetype)initWithFrame:(CGRect)frame controllers:(NSArray*)controllers titleArray:(NSArray*)titleArray parentController:(UIViewController*)parentC lineWidth:(float)lineW lineHeight:(float)lineH{
    if (self = [super initWithFrame:frame]) {

        float avgWidth = frame.size.width/controllers.count;

        self.controllers = controllers;
        self.nameArray = titleArray;


        self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,42)];
        self.segmentView.tag = 50;
        [self addSubview:self.segmentView];


        self.segmentScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 41, frame.size.width, frame.size.height - 41)];
        self.segmentScrollV.contentSize = CGSizeMake(frame.size.width*self.controllers.count,0);
        self.segmentScrollV.delegate = self;
        self.segmentScrollV.showsHorizontalScrollIndicator = false;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.bounces = NO;
        [self addSubview:self.segmentScrollV];
        self.backgroundColor = [UIColor blueColor];


        for (int i=0; i<self.controllers.count; i++) {
            UIViewController * controller = self.controllers[i];
            [self.segmentScrollV addSubview:controller.view];
            controller.view.frame = CGRectMake(i*frame.size.width,0,frame.size.width, frame.size.height);
            [parentC addChildViewController:controller];
            [controller didMoveToParentViewController:parentC];
        }


        for (int i=0; i<self.controllers.count; i++) {

            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, 41);
            btn.tag = i;
            [btn setTitle:self.nameArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];

            [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:17.0];

            [self.segmentView addSubview:btn];

        }


        self.down = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 1)];
        self.down.backgroundColor = [UIColor purpleColor];
        [self.segmentView addSubview:self.down];


        self.line = [[UILabel alloc] initWithFrame:CGRectMake((avgWidth-lineW)/2, 41-lineH, lineW, lineH)];
        self.line.backgroundColor = [UIColor redColor];
        self.line.tag = 100;
        [self.segmentView addSubview:self.line];

    }
    return self;

}

-(void)Click:(UIButton*)sender{


    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.seleBtn.selected = NO;
    self.seleBtn = sender;
    self.seleBtn.selected = YES;
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [UIView animateWithDuration:0.2 animations:^{

        CGPoint frame = self.line.center;
        frame.x = self.frame.size.width/(self.controllers.count*2) + (self.frame.size.width/self.controllers.count)*(sender.tag);
        self.line.center = frame;

    }];
    [self.segmentScrollV setContentOffset:CGPointMake(sender.tag * self.frame.size.width, 0) animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [UIView animateWithDuration:0.2 animations:^{


        CGPoint frame = self.line.center;
        frame.x = self.frame.size.width / (self.controllers.count*2) + (self.frame.size.width/self.controllers.count) * (self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center = frame;


    }];


    UIButton * btn = (UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected = NO;
    self.seleBtn = btn;
    self.seleBtn.selected = YES;


    NSLog(@"12345");
    //frameT = self.line.center;


}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    frameT = self.line.center;
    historyX = scrollView.contentOffset.x;
    NSLog(@"XXXXX");
}




@end
