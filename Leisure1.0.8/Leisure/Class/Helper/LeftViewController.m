//
//  LeftViewController.m
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "LeftViewController.h"
#import "DrawViewController.h"
#import "CollectionViewController.h"
#import "DownloadViewController.h"

#define kTableHeader self.tableView.tableHeaderView
#define kTableHeaderWidth self.tableView.tableHeaderView.frame.size.width
#define kTableHeaderHeight self.tableView.tableHeaderView.frame.size.height

@interface LeftViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)UIButton *loginBtn;
@property (strong, nonatomic)UIButton *logonBtn;
@property (strong, nonatomic)UIButton *collectBtn;     //收藏
@property (strong, nonatomic)UIButton *downloadBtn;    //下载
@property (strong, nonatomic)UIButton *logOut;         //退出登录
@property (strong, nonatomic)UILabel *nameLabel;       //用户名
@property (strong, nonatomic)UILabel *levelLabel;      //等级
@property (strong, nonatomic)UITextField *userName;
@property (strong, nonatomic)UITextField *userPwd;
@property (strong, nonatomic)UITapGestureRecognizer *tapImageView;
@property (assign, nonatomic)BOOL isTap;
@property (assign, nonatomic)BOOL isImage;

@end

@implementation LeftViewController

#pragma mark - 懒加载
- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.layer.cornerRadius = 40;
        _imageView.layer.masksToBounds = YES;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        
        _loginBtn = [self createButtonWithTitle:@"登录" selector:@selector(loginBtnAction:)];
    }
    return _loginBtn;
}

- (UIButton *)logonBtn {
    
    if (!_logonBtn) {
        
        _logonBtn = [self createButtonWithTitle:@"注册" selector:@selector(logonBtnAction:)];
    }
    return _logonBtn;
}

- (UIButton *)collectBtn {
    
    if (!_collectBtn) {
        
        _collectBtn = [self createButtonWithTitle:@"已收藏" selector:@selector(collectBtnAction:)];
    }
    return _collectBtn;
}

- (UIButton *)downloadBtn {
    
    if (!_downloadBtn) {
        
        _downloadBtn = [self createButtonWithTitle:@"已下载" selector:@selector(downloadBtnAction:)];
    }
    return _downloadBtn;
}

- (UIButton *)logOut {
    
    if (!_logOut) {
        
        _logOut = [self createButtonWithTitle:@"登出" selector:@selector(logOutBtnAction:)];
    }
    return _logOut;
}

- (UITextField *)userName {
    
    if (!_userName) {
        
        _userName = [[UITextField alloc] init];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.borderStyle = UITextBorderStyleRoundedRect;
        _userName.clearButtonMode = UITextFieldViewModeAlways;
        _userName.placeholder = @"请输入用户名";
        _userName.delegate = self;
    }
    return _userName;
}

- (UITextField *)userPwd {
    
    if (!_userPwd) {
        
        _userPwd = [[UITextField alloc] init];
        _userPwd.textAlignment = NSTextAlignmentCenter;
        _userPwd.borderStyle = UITextBorderStyleRoundedRect;
        _userPwd.clearButtonMode = UITextFieldViewModeAlways;
        _userPwd.secureTextEntry = YES;
        _userPwd.placeholder = @"请输入密码";
        _userPwd.delegate = self;
    }
    return _userPwd;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UILabel *)levelLabel {
    
    if (!_levelLabel) {
        
        _levelLabel = [[UILabel alloc] init];
    }
    return _levelLabel;
}

- (UITapGestureRecognizer *)tapImageView {
    
    if (!_tapImageView) {
        
        _tapImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewAction:)];
    }
    return _tapImageView;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[DrawViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ReadViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[RedioViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[TopicViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[GoodsViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        default:
            break;
    }
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"主页", @"阅读", @"电台", @"话题", @"良品"];
//    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    cell.textLabel.text = titles[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

#pragma mark - UIButton
//头视图中的控件
- (void)createHeaderViewControl {
    
    //头像
    [self.tableView.tableHeaderView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(kTableHeader.mas_left).offset(10);
        make.centerY.equalTo(kTableHeader.mas_top).offset(kTableHeaderHeight/2);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    //手势
    [self.imageView addGestureRecognizer:self.tapImageView];
    
    //登录按钮
    [self.tableView.tableHeaderView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.equalTo(kTableHeader.mas_left).offset(kTableHeaderWidth*2/9);
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
    }];
    
    //注册按钮
    [self.tableView.tableHeaderView addSubview:self.logonBtn];
    [self.logonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.equalTo(kTableHeader.mas_left).offset(kTableHeaderWidth*4/9);
        make.top.equalTo(self.imageView.mas_bottom).offset(0);
    }];
    
    //收藏
    [self.tableView.tableHeaderView addSubview:self.collectBtn];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(self.imageView.mas_left).offset(10);
        make.top.equalTo(kTableHeader.mas_top).offset(30);
    }];
    
    //下载
    [self.tableView.tableHeaderView addSubview:self.downloadBtn];
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.top.equalTo(kTableHeader.mas_top).offset(30);
    }];
    
    
    //用户名textField
    [kTableHeader addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(168, 30));
        make.top.equalTo(self.imageView.mas_top).offset(0);
        make.left.equalTo(self.imageView.mas_right).offset(10);
    }];
    
    //密码textField
    [kTableHeader addSubview:self.userPwd];
    [self.userPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(168, 30));
        make.bottom.equalTo(self.imageView.mas_bottom).offset(0);
        make.left.equalTo(self.imageView.mas_right).offset(10);
    }];
}

// 创建button
- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector {
    
    UIButton *button = ({
        
        button = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [button setTitle:title forState:(UIControlStateNormal)];
        [button addTarget:self action:selector forControlEvents:(UIControlEventTouchUpInside)];
        button.tintColor = [UIColor whiteColor];
        button;
    });
    return button;
}

//登录按钮
- (void)loginBtnAction:(UIButton *)sender {
    
    if ((!self.userName.text) || [self.userName.text isEqualToString:@""]) {
        
        [self alertController:@"用户名不能为空啦╮(╯_╰)╭"];
    }
    else if ((!self.userPwd.text) || [self.userPwd.text isEqualToString:@""]) {
        
        [self alertController:@"密码不能为空啦╮(╯_╰)╭"];
    }
    else {
        
        [AVUser logInWithUsernameInBackground:self.userName.text password:self.userPwd.text block:^(AVUser *user, NSError *error) {
            if (user != nil) {
                
                self.isTap = YES;
                [self.userName removeFromSuperview];
                [self.userPwd removeFromSuperview];
                [UIView animateWithDuration:1 animations:^{
                    
                    self.imageView.center = CGPointMake(kTableHeaderWidth*7/20, kTableHeaderHeight/2);
                }];
                [self.loginBtn removeFromSuperview];
                [self.logonBtn removeFromSuperview];
                
                //用户名label
                [self.tableView.tableHeaderView addSubview:self.nameLabel];
                [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(CGSizeMake(170, 30));
                    make.top.equalTo(self.imageView.mas_top).offset(0);
                    make.left.equalTo(self.imageView.mas_right).offset(10);
                }];
                
                //等级label
                _nameLabel.text = [AVUser currentUser].username;
                [self.tableView.tableHeaderView addSubview:self.levelLabel];
                [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(CGSizeMake(170, 30));
                    make.bottom.equalTo(self.imageView.mas_bottom).offset(0);
                    make.left.equalTo(self.imageView.mas_right).offset(10);
                }];
                
                //登出按钮
                _levelLabel.text = @"🐳🐳🐳🐬🐬🐟";
                [self.tableView.tableHeaderView addSubview:self.logOut];
                [self.logOut mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.size.mas_equalTo(CGSizeMake(30, 30));
                    make.top.equalTo(self.imageView.mas_bottom).offset(0);
                    make.centerX.equalTo(self.imageView.mas_centerX).offset(0);
                }];
                [self alertController:@"此应用木有没有盗版任何QQ应用,这是集美貌与智慧于一身的pengma费劲千辛万苦才做粗来的╭(╯^╰)╮哼~~,不许说我草席,我木有草席,绝对木有,木有!!!"];
            } else {
                
                [self alertController:@"登录失败,用户名或密码错误啦╮(╯_╰)╭,快点检查一下😔"];
            }
//            if (self.isImage == NO) {
//                
//                [self alertController:@"哎呀头像怎么跑偏了？快点一下登录,把它纠正过来"];
//                self.isImage = YES;
//            }
        }];
    }
}

//注册按钮
- (void)logonBtnAction:(UIButton *)sender {
    
    if ((!self.userName.text) || [self.userName.text isEqualToString:@""]) {
        
        [self alertController:@"用户名不能为空啦╮(╯_╰)╭"];
    }
    else if ((!self.userPwd.text) || [self.userPwd.text isEqualToString:@""]) {
        
        [self alertController:@"密码不能为空啦╮(╯_╰)╭"];
    }
    else {
        
        AVUser *user = [AVUser user];// 新建 AVUser 对象实例
        user.username = self.userName.text;// 设置用户名
        user.password =  self.userPwd.text;// 设置密码
        //    user.email = @"tom@leancloud.cn";// 设置邮箱
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
                [self alertController:@"恭喜你注册成功啦~\(≧▽≦)/~啦啦,赶快去登录吧😘"];
            } else {
                
                [self alertController:@"注册失败了😢,失败的原因可能有多种,换一个用户名试试😖"];
            }
        }];
    }
}

//收藏
- (void)collectBtnAction:(UIButton *)sender {
    
    CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:collectionVC];
//    [self presentViewController:navC animated:YES completion:nil];
    [self.sideMenuViewController setContentViewController:navC];
    [self.sideMenuViewController hideMenuViewController];
}

//下载
- (void)downloadBtnAction:(UIButton *)sender {
    
    DownloadViewController *downloadVC = [DownloadViewController shareDownloadViewController];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:downloadVC];
//    [self presentViewController:navC animated:YES completion:nil];
    [self.sideMenuViewController setContentViewController:navC];
    [self.sideMenuViewController hideMenuViewController];
}

//登出
- (void)logOutBtnAction:(UIButton *)sender {
    
    [AVUser logOut];  //清除缓存用户对象
    AVUser *currentUser = [AVUser currentUser]; // 现在的currentUser是nil了
    if (currentUser == nil) {
        
        [self alertController:@"退出成功,你要离开我了吗😖,我还会回来的"];
        self.userName.text = @"";
        self.userPwd.text = @"";
        self.imageView.image = nil;
        self.nameLabel.text = @"";
        self.levelLabel.text = @"";
        [self createHeaderViewControl];
        [self.logOut removeFromSuperview];
    }
    else {
        
        [self alertController:@"退出失败,我是不会放过你的😂"];
    }
}


#pragma mark - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidths, kHeights) style:UITableViewStylePlain];
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidths, kHeights/3)];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
    [self createHeaderViewControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 手势换头像
- (void)tapImageViewAction:(UITapGestureRecognizer *)sender {
    
    if (self.isTap) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
//        if (self.isImage == YES) {
//            
//            [self alertController:@"哎呀头像怎么跑偏了？快点一下登录,把它纠正过来"];
//        }
    }
    else {
        
        [self alertController:@"你还没有登录,怎么可以换头像😞"];
    }
}

//实现imagePickerVC的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //取得所选取的图片
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = selectImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 警示框
- (void)alertController:(NSString *)alertContent{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:alertContent preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - UITextField的回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.userName resignFirstResponder];
    [self.userPwd resignFirstResponder];
    return YES;
}

@end
