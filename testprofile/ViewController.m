//
//  ViewController.m
//  testprofile
//
//  Created by 村上優孝 on 2015/03/25.
//  Copyright (c) 2015年 村上優孝. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSDictionary *profile = [self getJSON];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // プロフィールの背景画像
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1.0];
    [self.view addSubview:backgroundView];
    
    // サムネイル画像をダウンロード
    NSURL *url = [NSURL URLWithString:profile[@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    // サムネイル画像
    UIImageView *thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(25, 35, 48, 48)];
    thumbnail.image = image;
    [self.view addSubview:thumbnail];

    // 名前
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 35, 100, 100)];
    nameLabel.text = profile[@"name"];
    nameLabel.font = [UIFont fontWithName:@"AppleGothic" size:20];
    [nameLabel sizeToFit];
    [self.view addSubview:nameLabel];
    
    // スクリーンネーム
    UILabel *screenNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 63, 100, 100)];
    screenNameLabel.text = [NSString stringWithFormat:@"@%@",profile[@"screen_name"]];
    screenNameLabel.textColor = [UIColor grayColor];
    screenNameLabel.font = [UIFont fontWithName:@"AppleGothic" size:12];
    [screenNameLabel sizeToFit];
    [self.view addSubview:screenNameLabel];
    
    // プロフィールの分割線
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 1)];
    horizontalLine.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
    [self.view addSubview: horizontalLine];
    
    // フォローの数
    UILabel *followCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, 100, 100)];
    followCountLabel.text = [NSString stringWithFormat:@"%@",profile[@"follow_counts"]];
    followCountLabel.font = [UIFont fontWithName:@"AppleGothic" size:14];
    [followCountLabel sizeToFit];
    [self.view addSubview:followCountLabel];
    
    // フォローラベル
    UILabel *followLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 130, 100, 100)];
    followLabel.text = @"フォロー";
    followLabel.textColor = [UIColor grayColor];
    followLabel.font = [UIFont fontWithName:@"AppleGothic" size:11];
    [followLabel sizeToFit];
    [self.view addSubview:followLabel];

    // フォロワーの数
    UILabel *followerCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 110, 100, 100)];
    followerCountLabel.text = [NSString stringWithFormat:@"%@",profile[@"follower_counts"]];
    followerCountLabel.font = [UIFont fontWithName:@"AppleGothic" size:14];
    [followerCountLabel sizeToFit];
    [self.view addSubview:followerCountLabel];
    
    // フォロワーラベル
    UILabel *followerLavel = [[UILabel alloc] initWithFrame:CGRectMake(135, 130, 100, 100)];
    followerLavel.text = @"フォロワー";
    followerLavel.textColor = [UIColor grayColor];
    followerLavel.font = [UIFont fontWithName:@"AppleGothic" size:11];
    [followerLavel sizeToFit];
    [self.view addSubview:followerLavel];
    
    // 設定マーク
    UIImageView *settingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, 110, 18, 18)];
    settingImageView.image = [UIImage imageNamed:@"gear.png"];
    [self.view addSubview:settingImageView];
    
    // 設定ラベル
    UILabel *settingLabel = [[UILabel alloc] initWithFrame:CGRectMake(258, 130, 100, 100)];
    settingLabel.text = @"設定";
    settingLabel.textColor = [UIColor grayColor];
    settingLabel.font = [UIFont fontWithName:@"AppleGothic" size:11];
    [settingLabel sizeToFit];
    [self.view addSubview:settingLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)getJSON{
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/1jojf"];
    /** JSON Example
     {
     name: "example",
     screen_name: "example.inc",
     follow_counts: 234,
     follower_counts: 123,
     image: "http://i.imgur.com/ELtLVZy.jpg"
     }
     */
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    return dictionary;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:
(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"メンバー・アカウント管理";
            break;
        case 1:
            cell.textLabel.text = @"プロフィール";
            break;
        case 2:
            cell.textLabel.text = @"友だちに教える";
            break;
        case 3:
            cell.textLabel.text = @"応答モード";
            break;
        case 4:
            cell.textLabel.text = @"ホーム設定";
            break;
        case 5:
            cell.textLabel.text = @"アカウント設定";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:
(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"profileEdit" sender:self];
    }
}

@end
