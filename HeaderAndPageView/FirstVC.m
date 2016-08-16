//
//  FirstVC.m
//  HeaderAndPageView
//
//  Created by langyue on 16/8/16.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView* myTabView;



@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    _myTabView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _myTabView.delegate = self;
    _myTabView.dataSource = self;
    _myTabView.showsVerticalScrollIndicator = NO;
    _myTabView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTabView];

    _myTabView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController * vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = [NSString stringWithFormat:@"homePageCellIdentifier%@",indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"onetableForIndex.row =%ld",indexPath.row];
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
