//
//  ViewController.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "ViewController.h"

#import "HJCActionSheet.h"
#import "UIBezierPath+ZJText.h"
#import "PDPullToRefresh.h"
#import "FDAlertView.h"
#import "ContentView.h"
#import "MBTwitterScroll.h"
#import "PopoverViewController.h"
#import "BHBPopView.h"
#import "PopArrowTable.h"
#import "BAButton.h"

@interface ViewController ()<PopArrowTableDelegate,HJCActionSheetDelegate,UITableViewDataSource,FDAlertViewDelegate,MBTwitterScrollDelegate,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) UITextField *txtField;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSMutableDictionary *attrs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    switch (_index) {
        case 1:
            [self HJCActionSheetView];
            break;
        case 2:
            [self writeText];
            break;
        case 3:
        {
            [self initTableView];
            [self addPDRefresh];
        }
            break;
        case 4:
            [self AlertView];
            break;
        case 5:
            [self MBTwitterScroll];
            break;
        case 6:
            [self POPAnimation];
            break;
        case 7: 
            [self popArrowTable];
            break;
        case 9: //BAButton
            [self BAButton];
            break;
        default:
            break;
    }
}




#pragma mark - HJCActionSheet

- (void)HJCActionSheetView{
    UIButton *btn=[UIButton buttonWithTitle:@"Click" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick)];
    btn.frame=CGRectMake(0, 70, 60, 30);
    [self.view addSubview:btn];
}

- (void)btnClick{
    // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"哈哈", @"嘿嘿", @"哄哄", nil];
    // 2.显示出来
    [sheet show];
}
// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
//            _testLabel.text = @"哈哈";
            break;
        case 2:
//            _testLabel.text = @"嘿嘿";
            break;
        case 3:
//            _testLabel.text = @"哄哄";
            break;
    }
}

#pragma mark - 文字绘写
#pragma mark 写文字
- (void)writeText{
    [self.view.layer addSublayer:self.shapeLayer];
    
    UIButton *btn=[UIButton buttonWithTitle:@"Click" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(writeBtnClick)];
    btn.frame=CGRectMake(0, 70, 60, 30);
    [self.view addSubview:btn];
    
//    self.txtField.delegate = self;
    self.txtField.text = @"load...";
}
- (void)writeBtnClick{
    if (_txtField.text.length > 0)
    {
        UIBezierPath *path = [UIBezierPath zjBezierPathWithText:_txtField.text attributes:self.attrs];
        self.shapeLayer.bounds = CGPathGetBoundingBox(path.CGPath);
        self.shapeLayer.path = path.CGPath;
        
        
        [self.shapeLayer removeAllAnimations];
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.5f * _txtField.text.length;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    }
}
-(UITextField *)txtField{
    if (_txtField==nil) {
        _txtField=[[UITextField alloc]initWithFrame:CGRectMake(80, 70, 60, 30)];
        [self.view addSubview:_txtField];
    }
    return _txtField;
}
-(CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil)
    {
        _shapeLayer = [CAShapeLayer layer];
        
        CGSize size = self.view.frame.size;
        CGFloat height = 250;
        
        _shapeLayer.frame = CGRectMake(0, (size.height - height)/2, size.width , height);
        _shapeLayer.geometryFlipped = YES;
        _shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;;
        _shapeLayer.lineWidth = 2.0f;
        _shapeLayer.lineJoin = kCALineJoinRound;
    }
    return _shapeLayer;
}

-(NSMutableDictionary *)attrs
{
    if (_attrs == nil)
    {
        _attrs = [[NSMutableDictionary alloc] init];
        [_attrs setValue:[UIFont boldSystemFontOfSize:50] forKey:NSFontAttributeName];
    }
    return _attrs;
}

#pragma mark 刷新文字
- (void)addPDRefresh
{
    [self.tableView pd_addHeaderRefreshWithNavigationBar:YES andActionHandler:^{
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Header - ActionHandler");
            [self.tableView.pdHeaderRefreshView stopRefreshing];
        });
    }];
    //    [self.tableView.pdHeaderRefreshView startRefreshing];
    
    [self.tableView pd_addFooterRefreshWithNavigationBar:YES andActionHandler:^{
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Footer - ActionHandler");
            [self.tableView.pdFooterRefreshView stopRefreshing];
        });
    }];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld条",(long)indexPath.row];
    return cell;
}

#pragma  mark - AlertView
- (void)AlertView{
    UIButton *btn=[UIButton buttonWithTitle:@"一般的信息弹框" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick2:)];
    btn.frame=CGRectMake(0, 70, 160, 30);
    btn.tag=100;
    [self.view addSubview:btn];
    UIButton *btn1=[UIButton buttonWithTitle:@"带图标的信息弹框" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick2:)];
    btn1.frame=CGRectMake(0, 170, 160, 30);
    btn1.tag=101;
    [self.view addSubview:btn1];
    UIButton *btn2=[UIButton buttonWithTitle:@"可自定义内容弹框" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick2:)];
    btn2.frame=CGRectMake(0, 270, 160, 30);
    btn2.tag=102;
    [self.view addSubview:btn2];
}
- (void)btnClick2:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
        {
            FDAlertView *alert = [[FDAlertView alloc] initWithTitle:@"退出登录" icon:nil message:@"确定退出登录吗？" delegate:self buttonTitles:@"确定", @"取消", nil];
            [alert setMessageColor:[UIColor redColor] fontSize:0];
            [alert show];
        }
            break;
        case 101:
        {
            FDAlertView *alert = [[FDAlertView alloc] initWithTitle:@"退出登录" icon:[UIImage imageNamed:@"exclamation-icon"] message:@"你确定退出登录吗？" delegate:self buttonTitles:@"确定", @"取消", nil];
            [alert show];
        }
            break;
        case 102:
        {
            FDAlertView *alert = [[FDAlertView alloc] init];
            ContentView *contentView = [[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:nil options:nil].lastObject;
            contentView.frame = CGRectMake(0, 0, 270, 220);
            alert.contentView = contentView;
            [alert show];
        }
            break;
            
        default:
            break;
    }
}
- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
}

#pragma  mark  - MBTwitterScroll
- (void)MBTwitterScroll{
    MBTwitterScroll *myTableView = [[MBTwitterScroll alloc]
                                    initTableViewWithBackgound:[UIImage imageNamed:@"background"]
                                    avatarImage:[UIImage imageNamed:@"avatar.png"]
                                    titleString:@"Main title"
                                    subtitleString:@"Sub title"
                                    buttonTitle:@"Follow"];  // Set nil for no button
    
    myTableView.tableView.delegate = self;
    myTableView.tableView.dataSource = self;
    myTableView.delegate = self;
    [myTableView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];

    [self.view addSubview:myTableView];
    
    /*
     MBTwitterScroll *myScrollView = [[MBTwitterScroll alloc]
     initScrollViewWithBackgound:nil
     avatarImage:[UIImage imageNamed:@"avatar.png"]
     titleString:@"Main title"
     subtitleString:@"Sub title"
     buttonTitle:@"Follow" // // Set nil for no button
     contentHeight:2000];
     myScrollView.delegate = self;
     [self.view addSubview:myScrollView];
     */
}

-(void) recievedMBTwitterScrollEvent {
  
//    第一步：要获取单独控制器所在的UIStoryboard
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    第二步：获取该控制器的Identifier并赋给你的单独控制器
    PopoverViewController *vc = [story instantiateViewControllerWithIdentifier:@"PopoverViewController"];
    vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:vc animated:YES completion:nil];
    
//    [self performSegueWithIdentifier:@"showPopover" sender:self];
}


- (void) recievedMBTwitterScrollButtonClicked {
    NSLog(@"Button Clicked");
}


#pragma mark - 新浪弹框动画
- (void)POPAnimation{
    UIButton *btn=[UIButton buttonWithTitle:@"Click" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(POPBtnClick)];
    btn.frame=CGRectMake(0, 70, 60, 30);
    [self.view addSubview:btn];
}
- (void)POPBtnClick{
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"Text" Icon:@"images.bundle/tabbar_compose_idea"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"Albums" Icon:@"images.bundle/tabbar_compose_photo"];
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"Camera" Icon:@"images.bundle/tabbar_compose_camera"];
    //第4个按钮内部有一组
    BHBGroup * item3 = [[BHBGroup alloc]initWithTitle:@"Check in" Icon:@"images.bundle/tabbar_compose_lbs"];
    BHBItem * item31 = [[BHBItem alloc]initWithTitle:@"Friend Circle" Icon:@"images.bundle/tabbar_compose_friend"];
    BHBItem * item32 = [[BHBItem alloc]initWithTitle:@"Weibo Camera" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    BHBItem * item33 = [[BHBItem alloc]initWithTitle:@"Music" Icon:@"images.bundle/tabbar_compose_music"];
    item3.items = @[item31,item32,item33];
    
    BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"Review" Icon:@"images.bundle/tabbar_compose_review"];
    
    //第六个按钮内部有一组
    BHBGroup * item5 = [[BHBGroup alloc]initWithTitle:@"More" Icon:@"images.bundle/tabbar_compose_more"];
    BHBItem * item51 = [[BHBItem alloc]initWithTitle:@"Friend Circle" Icon:@"images.bundle/tabbar_compose_friend"];
    BHBItem * item52 = [[BHBItem alloc]initWithTitle:@"Weibo Camera" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    BHBItem * item53 = [[BHBItem alloc]initWithTitle:@"Music" Icon:@"images.bundle/tabbar_compose_music"];
    BHBItem * item54 = [[BHBItem alloc]initWithTitle:@"Blog" Icon:@"images.bundle/tabbar_compose_weibo"];
    BHBItem * item55 = [[BHBItem alloc]initWithTitle:@"Collection" Icon:@"images.bundle/tabbar_compose_transfer"];
    BHBItem * item56 = [[BHBItem alloc]initWithTitle:@"Voice" Icon:@"images.bundle/tabbar_compose_voice"];
    item5.items = @[item51,item52,item53,item54,item55,item56];
    
    
    //添加popview
    [BHBPopView showToView:self.view.window withItems:@[item0,item1,item2,item3,item4,item5]andSelectBlock:^(BHBItem *item) {
        if ([item isKindOfClass:[BHBGroup class]]) {
            NSLog(@"选中%@分组",item.title);
        }else{
            NSLog(@"选中%@项",item.title);
        }
    }];
    //添加popview
    //    [BHBPopView showToView:self.view andImages:@[@"images.bundle/tabbar_compose_idea",@"images.bundle/tabbar_compose_photo",@"images.bundle/tabbar_compose_camera",@"images.bundle/tabbar_compose_lbs",@"images.bundle/tabbar_compose_review",@"images.bundle/tabbar_compose_more"] andTitles:@[@"Text",@"Albums",@"Camera",@"Check in",@"Review",@"More"] andSelectBlock:^(BHBItem *item) {
    //
    //    }];

}

#pragma mark - 带箭头弹框
- (void)popArrowTable {
    
    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downBtn setTitle:@"world" forState:UIControlStateNormal];
    downBtn.frame = CGRectMake(10, 400, 100, 100);
    [self.view addSubview:downBtn];
    [downBtn addTarget:self
                     action:@selector(showTable:)
           forControlEvents:UIControlEventTouchUpInside];
    [downBtn setBackgroundColor:[UIColor purpleColor]];
}
- (void)showTable:(UIButton *)btn {
    PopArrowTable *view=[PopArrowTable new];
    view.delegate=self;
    [view showAtPointView:btn];
}

#pragma mark -- BAButton
- (void)BAButton {
    [self buttonTest];
}
- (void)buttonTest
{
    BACustomButton *btn = [BACustomButton BA_ShareButton];
    btn.backgroundColor = [UIColor greenColor];;
    [btn setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn setTitle:@"系统默认样式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.buttonStatus = BAAligenmentStatusNormal;
    btn.buttonCornerRadius = 5.0;
    btn.frame = CGRectMake(50, 50, 200, 50);
    [self.view addSubview:btn];
    
    //    BAButton *btn = [[BAButton alloc] initWithFrame:CGRectMake(100, 100, 200, 30) image:[UIImage imageNamed:@"btn_share"] highlightedImage:[UIImage imageNamed:@"btn_share"] fadeDuration:3];
    //    btn.backgroundColor = [UIColor greenColor];
    //    //    [btn setImage:[UIImage imageNamed:@"tabbar_discover"] forState:UIControlStateNormal];
    //    [btn setTitle:@"默认" forState:UIControlStateNormal];
    //    //    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    //    btn.buttonStatus = BAAligenmentStatusNormal;
    //    //    btn.buttonCornerRadius = 5.0;
    //    //    btn.frame = CGRectMake(100, 100, 200, 30);
    //    [self.view addSubview:btn];
    
    BACustomButton *btn1 = [BACustomButton BA_ShareButton];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [btn1 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn1 setTitle:@"左对齐[文字左图片右]" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.buttonStatus = BAAligenmentStatusLeft;
    btn1.buttonCornerRadius = 5.0;
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    btn1.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame) + 10, 200, 50);
    [self.view addSubview:btn1];
    
    BACustomButton *btn2 = [BACustomButton BA_ShareButton];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn2 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn2 setTitle:@"中心对齐[文字左图片右]" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.buttonStatus = BAAligenmentStatusCenter;
    btn2.buttonCornerRadius = 5.0;
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    btn2.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn1.frame) + 10, 300, 50);
    [self.view addSubview:btn2];
    
    BACustomButton *btn3 = [BACustomButton BA_ShareButton];
    [btn3 setBackgroundColor:[UIColor greenColor]];
    [btn3 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn3 setTitle:@"右对齐[文字左图片右]" forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:10];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.buttonStatus = BAAligenmentStatusRight;
    btn3.buttonCornerRadius = 5.0;
    btn3.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn2.frame) + 10, 200, 50);
    [self.view addSubview:btn3];
    
    BACustomButton *btn4 = [[BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusLeft];
    [btn4 setBackgroundColor:[UIColor greenColor]];
    [btn4 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn4 setTitle:@"左对齐[文字左图片右]" forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:10];
    btn4.buttonCornerRadius = 5.0;
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn4.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn3.frame) + 10, 200, 50);
    [self.view addSubview:btn4];
    
    BACustomButton *btn5 = [[BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusTop];
    [btn5 setBackgroundColor:[UIColor greenColor]];
    [btn5 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn5 setTitle:@"图片在上，文字在下" forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:10];
    btn5.buttonCornerRadius = 5.0;
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn5.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn4.frame) + 10, 200, 80);
    [self.view addSubview:btn5];
    
    BACustomButton *btn6 = [[BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusBottom];
    [btn6 setBackgroundColor:[UIColor greenColor]];
    [btn6 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn6 setTitle:@"图片在下，文字在上" forState:UIControlStateNormal];
    btn6.titleLabel.font = [UIFont systemFontOfSize:10];
    btn6.buttonCornerRadius = 5.0;
    [btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn6.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn5.frame) + 10, 150, 80);
    [self.view addSubview:btn6];
    
    BACustomButton *btn7 = [[BACustomButton alloc] init];
    btn7.buttonStatus = BAAligenmentStatusBottom;
    [btn7 setBackgroundColor:[UIColor greenColor]];
    [btn7 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [btn7 setTitle:@"图片在下，文字在上" forState:UIControlStateNormal];
    btn7.titleLabel.font = [UIFont systemFontOfSize:13];
    btn7.buttonCornerRadius = 5.0;
    [btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn7.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn6.frame) + 10, 150, 80);
    [self.view addSubview:btn7];
}
#pragma mark -- PopArrowTableDelegate
- (void)PopArrowTable:(PopArrowTable *)PopArrowTable didSelectRowAtIndexPath:(NSInteger)indexPath {
    NSLog(@"%ld", indexPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
