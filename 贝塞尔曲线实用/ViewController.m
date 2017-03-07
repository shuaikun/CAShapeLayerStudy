//
//  ViewController.m
//  贝塞尔曲线实用
//
//  Created by caoshuaikun on 2017/2/10.
//  Copyright © 2017年 wuxiwenyan. All rights reserved.
//

#import "ViewController.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define LanPangZiDuration 0.5
#define Cat_Frame_Y 140

@interface ViewController ()

@property (nonatomic, strong) CAShapeLayer * shapeLayer;//画圆
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) UIView *bezierView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.bezierView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, Screen_Width, Screen_Height - 200)];
    self.bezierView.backgroundColor = [UIColor colorWithRed:118 / 258.0 green:255 / 256.0 blue:194 / 256.0 alpha:1.0];
    [self.view addSubview:self.bezierView];
    
    [self 折线段顺带五边形];
    [self 圆形顺带一个简单动画];
    [self 画一条虚线];
    [self 画一个二次元线];
    [self 最难得一个画一个哆啦A梦];
}

- (void)折线段顺带五边形 {
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(Screen_Width / 2, 20)];
    [bezierPath addLineToPoint:CGPointMake(Screen_Width / 2 + 50, 50)];
    [bezierPath addLineToPoint:CGPointMake(Screen_Width / 2 + 50, 100)];
    [bezierPath addLineToPoint:CGPointMake(Screen_Width / 2 - 50, 100)];
    [bezierPath addLineToPoint:CGPointMake(Screen_Width / 2 - 50, 50)];
    [bezierPath closePath];
    
    CAShapeLayer * shapelayer = [CAShapeLayer layer];
    shapelayer.lineWidth = 5;
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    shapelayer.strokeColor = [UIColor orangeColor].CGColor;
    shapelayer.path = bezierPath.CGPath;
    [self.bezierView.layer addSublayer:shapelayer];
}

- (void)圆形顺带一个简单动画 {
    
    [self circleBezierPath];
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)circleBezierPath {
    
    //创建出CAShapeLayer 把他想象成一个画布
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(Screen_Width / 2 - 100, 20, 200, 100);//设置shapeLayer的尺寸和位置
    //    self.shapeLayer.position = self.view.center;//位置在中心
    self.shapeLayer.fillColor = [UIColor orangeColor].CGColor;//填充颜色为ClearColor 线条的填充色
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 5.0f;//画布上的线条的宽度
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;//线条的颜色
    self.shapeLayer.backgroundColor = [UIColor grayColor].CGColor;//画布背景色
//    self.shapeLayer.strokeStart = 0;//开始
//    self.shapeLayer.strokeEnd = 0;//结束
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =
//    //园
//    [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 50)];
//    //正方形
//    [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 25, 100, 50) cornerRadius:10];
//    //有点意思,某个角是圆角
//    [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 50) byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    //圆心 半径长度 开始角度 结束角度 是否顺时针 这是画圆弧的
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 50) radius:50 startAngle:M_PI * 1.5 endAngle:M_PI clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer];
}

- (void)circleAnimationTypeOne {
    
    //0 1 2 3 4 5 6 7 8 9 不是1 2 3 4 5 6 7 8 9 10这个地方注意
    if (self.shapeLayer.strokeEnd == 0.8) {
        [self.timer invalidate];// 从运行循环中移除， 对运行循环的引用进行一次 release
        self.timer = nil;// 将销毁定时器
    }
    
    if(self.shapeLayer.strokeStart == 0 && self.shapeLayer.strokeEnd < 0.8){
        self.shapeLayer.strokeEnd += 0.1;
    }
}

- (void)画一条虚线 {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 130, Screen_Width, 10);
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    shapeLayer.backgroundColor = [UIColor grayColor].CGColor;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.lineJoin = kCALineJoinRound;
    //5=线的宽度 2=每条线的间距
    shapeLayer.lineDashPattern = @[[NSNumber numberWithInt:5],[NSNumber numberWithInt:2]];
    
    //第一种写法
    UIBezierPath * besizier = [UIBezierPath bezierPath];
    [besizier moveToPoint:CGPointMake(10, 5)];
    [besizier addLineToPoint:CGPointMake(Screen_Width - 10,5)];
    shapeLayer.path = besizier.CGPath;
    
    //第二种写法
    //     Setup the path
    //    CGMutablePathRef path = CGPathCreateMutable();
    //    CGPathMoveToPoint(path, NULL, 10, 5);
    //    CGPathAddLineToPoint(path, NULL, Screen_Width - 10,5);
    //    shapeLayer.path = path;
    //    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [self.bezierView.layer addSublayer:shapeLayer];
    
}

- (void)画一个二次元线 {

    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(10, 180)];
    
    //拐两次弯
    [bezierPath addCurveToPoint:CGPointMake(Screen_Width / 2, 140) controlPoint1:CGPointMake(100, 120) controlPoint2:CGPointMake(200, 250)];
    //添加一个半圆
    [bezierPath addArcWithCenter:CGPointMake(200, 165) radius:25 startAngle:M_PI * 1.5 endAngle:M_PI_2 clockwise:YES];
    
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 5;
    shapLayer.fillColor = [UIColor clearColor].CGColor;
    shapLayer.strokeColor = [UIColor greenColor].CGColor;
    shapLayer.path = bezierPath.CGPath;
    [self.view.layer addSublayer:shapLayer];
}

- (void)最难得一个画一个哆啦A梦 {

    CGFloat arcCenterY = 80;
    CGFloat delay = LanPangZiDuration;
    CGFloat left_x = Screen_Width / 2 - 75;
    CGFloat catTop_y = 150; 
    
    //画出他的脸
    UIBezierPath * bezierpathFace = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(left_x, Cat_Frame_Y, catTop_y, catTop_y) cornerRadius:50];
    CAShapeLayer * shareLayerFace = [CAShapeLayer layer];
    [self setLayer:shareLayerFace path:bezierpathFace delay:delay];
    
    //眼睛
    CAShapeLayer * shareLayerLeftEye = [CAShapeLayer layer];
    UIBezierPath * bezierLeftEye = [UIBezierPath bezierPath];
    [bezierLeftEye moveToPoint:CGPointMake(left_x + 55, catTop_y + 40)];
    [bezierLeftEye addQuadCurveToPoint:CGPointMake(left_x + 55,  catTop_y + 70) controlPoint:CGPointMake(left_x + 35, catTop_y + 55)];
    [self setLayer:shareLayerLeftEye path:bezierLeftEye delay:delay];
    
    
}

- (void)setLayer:(CAShapeLayer *)layer path:(UIBezierPath *)path delay:(CFTimeInterval)delay {

    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.bezierView.layer addSublayer:layer];
    });
}


@end
