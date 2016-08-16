//
//  MainViewController.m
//  HeaderAndPageView
//
//  Created by langyue on 16/8/16.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "MainViewController.h"
#import "MainTouchTableView.h"
#import "MySegmentView.h"

#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"



static CGFloat const headViewHeight = 256;




@interface MainViewController()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)MainTouchTableView * mainTableView;

@property(nonatomic,strong)MySegmentView * SegView;//头部图片
@property(nonatomic,strong)UIImageView * headImgView;
@property(nonatomic,strong)UIImageView * avatarImage;
@property(nonatomic,strong)UILabel * countentLabel;

@property(nonatomic,assign)BOOL canScroll;
@property(nonatomic,assign)BOOL isTopIsCanNotMoveTabView;
@property(nonatomic,assign)BOOL isTopIsCanNotMoveTabViewPre;




@end



@implementation MainViewController


-(void)viewDidLoad{
    [super viewDidLoad];

    self.navigationItem.title = @"HeaderAndPageView";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainTableView];
    [self.mainTableView addSubview:self.headImgView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];

}


-(void)acceptMsg:(NSNotification*)notification{

    NSDictionary * userInfo = notification.userInfo;
    NSString * canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


    /**
     * 处理联动
     */

    //获取滚动视图y值的偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;

    CGFloat tabOffsetY = [_mainTableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;

    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY>=tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }


    /**
     * 处理头部视图
     */
    if(yOffset < -headViewHeight) {

        CGRect f = self.headImgView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        f.origin.y= yOffset;
        //改变头部视图的fram
        self.headImgView.frame= f;
        CGRect avatarF = CGRectMake(f.size.width/2-40, (f.size.height-headViewHeight)+56, 80, 80);
        _avatarImage.frame = avatarF;
        _countentLabel.frame = CGRectMake((f.size.width-kScreen_Width)/2+40, (f.size.height-headViewHeight)+172, kScreen_Width-80, 36);

    }

}



-(UIImageView*)headImgView{


    if (_headImgView == nil) {

        _headImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
        _headImgView.frame = CGRectMake(0, -headViewHeight, kScreen_Width, headViewHeight);
        _headImgView.userInteractionEnabled = YES;

        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2-40, 56, 80, 80)];
        [_headImgView addSubview:_avatarImage];
        _avatarImage.userInteractionEnabled = YES;
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.borderWidth = 1;
        _avatarImage.layer.borderColor = [UIColor colorWithRed:255/255 green:253/255.0 blue:253/255.0 alpha:1].CGColor;
        _avatarImage.image = [UIImage imageNamed:@"avatar.jpg"];


        _countentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, kScreen_Width-80, 30)];
        _countentLabel.font = [UIFont systemFontOfSize:12];
        _countentLabel.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1];
        _countentLabel.textAlignment = NSTextAlignmentCenter;
        _countentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _countentLabel.numberOfLines = 0;
        _countentLabel.text = @"我的名字叫Anna";
        [_headImgView addSubview:_countentLabel];

    }

    return _headImgView;
}



-(UITableView*)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[MainTouchTableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height-64)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.contentInset = UIEdgeInsetsMake(headViewHeight, 0, 0, 0);
        _mainTableView.backgroundColor = [UIColor purpleColor];
    }
    return _mainTableView;
}


#pragma mark - tableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreen_Height-64;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor yellowColor];
    //添加pageView
    [cell.contentView addSubview:[self setPageViewControllers]];
    return cell;
}





-(UIView*)setPageViewControllers{

    if (_SegView == nil) {
        
        FirstVC * firstVc = [[FirstVC alloc] init];
        SecondVC * secondVc = [[SecondVC alloc] init];
        ThirdVC * thirdVc = [[ThirdVC alloc] init];

        NSArray * controllers = @[firstVc,secondVc,thirdVc];
        NSArray * titleArray = @[@"first",@"second",@"third"];

        MySegmentView * segView = [[MySegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) controllers:controllers titleArray:titleArray parentController:self lineWidth:kScreen_Width/5 lineHeight:3];

        _SegView = segView;

    }
    return _SegView;

}



@end
