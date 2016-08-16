//
//  SecondVC.m
//  HeaderAndPageView
//
//  Created by langyue on 16/8/16.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * myTableView;


@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-40);
    _myTableView = [[UITableView alloc] initWithFrame:rect];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];

    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 60;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    NSString * identifier = [NSString stringWithFormat:@"homePageCellIdentifier%@",indexPath];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"secondtableForIndex.row =%ld",indexPath.row];

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
