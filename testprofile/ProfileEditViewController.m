//
//  ProfileEditViewController.m
//  testprofile
//
//  Created by 村上優孝 on 2015/03/27.
//  Copyright (c) 2015年 村上優孝. All rights reserved.
//

#import "ProfileEditViewController.h"

@interface ProfileEditViewController ()

@property NSDictionary *profile;

@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.profile = [self getJSON];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped]; // スタイルを「グループスタイル」にする
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)getJSON{
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/1jojf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    return dictionary;
}

-(NSInteger)numberOfSectionsInTableView:
(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 2;
        case 2:
            return 1;
        case 3:
            return 1;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 100;
        case 1:
            return 20;
        case 2:
            return 60;
        case 3:
            return 20;
        default:
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    switch (section) {
        case 0:
        {
            view.frame = CGRectMake(0, 0, 100, 100);
            
            // サムネイル
            NSURL *url = [NSURL URLWithString:self.profile[@"image"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 24, 15, 48, 48)];
            imageView.image = image;
            [view addSubview: imageView];
            
            // 名前
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 30, 70, 100, 100)];
            label.text = self.profile[@"name"];
            [label sizeToFit];
            [view addSubview: label];
            break;
        }
        case 1:
            view.frame = CGRectMake(0, 0, 100, 100);
            break;
        case 2:
        {
            view.frame = CGRectMake(0, 0, 100, 100);
            
            // ラベル
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 50)];
            label.text = @"LINE@アカウントを友だち追加した際に表示されるメッセージを設定できます";
            label.numberOfLines = 0;
            label.textColor = [UIColor grayColor];
            label.font = [UIFont fontWithName:@"AppleGothic" size:14];
            [view addSubview: label];

            break;
        }
        case 3:
            view.frame = CGRectMake(0, 0, 100, 100);
            break;
        default:
            break;
    }
    
    return view;
}

-(UITableViewCell *)tableView:
(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"名前";
                cell.detailTextLabel.text = self.profile[@"name"];
            } else if(indexPath.row == 1){
                cell.textLabel.text = @"ひとこと";
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"message"];
            }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"応答モード";
            } else if(indexPath.row == 1){
                cell.textLabel.text = @"友だち追加時あいさつ";
            }
            break;
        }
        case 2:
            cell.textLabel.text = @"ID";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"@%@",self.profile[@"name"]];
            break;
        case 3:
            cell.textLabel.text = @"友だちに教える";
            break;
        default:
            break;
    }
    
    return cell;
}

@end
