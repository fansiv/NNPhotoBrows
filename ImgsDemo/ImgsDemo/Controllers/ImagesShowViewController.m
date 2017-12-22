//
//  ImagesShowViewController.m
//  RuiYang
//
//  Created by Mac on 2017/12/21.
//  Copyright © 2017年 ruiyang. All rights reserved.
//

//屏幕高度、宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "ImagesShowViewController.h"
#import "UIImageView+WebCache.h"

@interface ImagesShowViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *mScrollView;
@property(nonatomic, assign) CGFloat currentImgHeight;//当前图片高度
@property(nonatomic, assign) NSInteger currentIndex;//当前页面
@property(nonatomic, assign) CGFloat nextImgHeight;//下一个高度
@property(nonatomic, strong) NSMutableArray *imgViews;//所有的图片视图

@end

@implementation ImagesShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (@available(iOS 11.0, *)) {
        self.mScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.imageUrlArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.imageHeights = [[NSMutableArray alloc] initWithCapacity:0];
    self.imgViews = [[NSMutableArray alloc] initWithCapacity:0];
    self.currentIndex = 0;
    
    //图片数据初始化
    [self initImageData];
//    [self initUrlImageData];
    //页面初始化
    [self initScrollView];
    
}

- (void)initImageData {
    for (int i = 0; i < 10; i ++) {
        [self.imageArray addObject:[NSString stringWithFormat:@"%d.jpg",i+1]];
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        CGFloat height = image.size.height / (image.size.width / kScreenWidth);
        if (i == 0) {
            self.currentImgHeight = height;
        }
        [self.imageHeights addObject:[NSNumber numberWithFloat:height]];
    }
}

- (void)initUrlImageData {
    NSArray * arr = @[
                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1526355747,1501969508&fm=27&gp=0.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513921110273&di=34f5c85c4ad15cfe68c537940a50e4d5&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2014%2F338%2F59%2FJR627I190L6G.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513921372401&di=9509e34e354f39747abe0176e7a7d391&imgtype=0&src=http%3A%2F%2Fimg05.tooopen.com%2Fimages%2F20140902%2Fsy_70028195254.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513921372400&di=275a16ac08f752a809316ffdce70e0fc&imgtype=0&src=http%3A%2F%2Ff7.topitme.com%2F7%2F1c%2F88%2F11258911656e6881c7o.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513921539803&di=6e87ffb587651f8bc4c2f588d71a5ca9&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F162%2F38%2F25DQXC5213WY.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513921539802&di=d5406c0e584c607d7e729c3e1a510722&imgtype=0&src=http%3A%2F%2Fimg17.3lian.com%2F201612%2F29%2F43bc9379314721ca71a76a75fcc2d5c9.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513921539829&di=397450184c5c526bc15bbd0802b0c9e8&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F136%2Fd%2F196.jpg",
                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513921539829&di=671746b8e48837dfaadbf05d67615659&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201209%2F28%2F20120928220354_TtLZS.thumb.700_0.jpeg",];
    NSArray * arrhs = @[
                        @"500×332",
                        @"900×1350",
                        @"1024×682",
                        @"627×708",
                        @"958×639",
                        @"1080×1920",
                        @"1440×900",
                        @"700×932",
                        ];
    for (int i = 0; i < arr.count; i ++) {
        [self.imageUrlArray addObject:arr[i]];
        NSArray * imgSize = [arrhs[i] componentsSeparatedByString:@"×"];
        CGFloat height = [imgSize.lastObject floatValue] / ([imgSize.firstObject floatValue] / kScreenWidth);
        if (i == 0) {
            self.currentImgHeight = height;
        }
        [self.imageHeights addObject:[NSNumber numberWithFloat:height]];
    }
    
}

- (void)initScrollView {
    
    self.mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.currentImgHeight)];
    self.mScrollView.contentSize = CGSizeMake(kScreenWidth * self.imageHeights.count, self.currentImgHeight);
//    self.mScrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.mScrollView.pagingEnabled = YES;
    self.mScrollView.delegate = self;
    self.mScrollView.bounces = NO;
    self.mScrollView.showsVerticalScrollIndicator = NO;
    self.mScrollView.showsHorizontalScrollIndicator = NO;
    //改变collectionView的滑动速度
    self.mScrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.view addSubview:self.mScrollView];

    for (int i = 0; i < self.imageHeights.count; i ++) {
        UIImageView * img = [[UIImageView alloc] init];
        if (self.imageUrlArray.count > 0) {
             [img sd_setImageWithURL:[NSURL URLWithString:self.imageUrlArray[i]] placeholderImage:[UIImage imageNamed:@"moren"]];
        }else{
             img.image = [UIImage imageNamed:self.imageArray[i]];
        }
        img.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, self.mScrollView.frame.size.height);
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.clipsToBounds = YES;
        [self.mScrollView addSubview:img];
        [self.imgViews addObject:img];
    }
    
}

#pragma mark  ----- scrollViewDelegate -----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x / kScreenWidth;//滑动中当前的页数
    self.currentImgHeight = [self.imageHeights[self.currentIndex] floatValue];//当前页图片高度
    CGFloat pianyi = scrollView.contentOffset.x - kScreenWidth * self.currentIndex;//相对于当前页偏移的高度
    CGFloat pianyizhishu = fabs(pianyi / kScreenWidth);//相对于屏幕宽度的偏移指数
    if (self.currentIndex == self.imageHeights.count - 1) {//如果是最后一页
        self.currentIndex = scrollView.contentOffset.x / kScreenWidth;
        self.currentImgHeight = [self.imageHeights[self.currentIndex] floatValue];
        scrollView.frame = CGRectMake(0, 0, kScreenWidth, self.currentImgHeight);
    }else{//其他
        self.nextImgHeight = [self.imageHeights[self.currentIndex + 1] floatValue];//下一个图片高度
        CGFloat chae = self.nextImgHeight - self.currentImgHeight;//两张图片差额差额（一个屏幕最多两张图）
        scrollView.frame = CGRectMake(0, 0, kScreenWidth, self.currentImgHeight + chae * pianyizhishu);//差额乘指数加上当前高度得到滑动中的高度
    }
//    NSLog(@"scrollView.frame.size.height ====== > %f",scrollView.frame.size.height);
    [self setimgsHeight:scrollView.frame.size.height];
}

//图片高度计算更改
- (void)setimgsHeight:(CGFloat)height {
    //更改ScrollView的contentSize
    self.mScrollView.contentSize = CGSizeMake(kScreenWidth * self.imageHeights.count, height);
    for (UIImageView * imgV in self.imgViews) {//更改每一个图片的位置
        NSInteger index = [self.imgViews indexOfObject:imgV];
        CGFloat bili = height / [self.imageHeights[index] floatValue];
        if (index <= self.currentIndex ) {//小于等于当前页的局右显示
            imgV.frame = CGRectMake(kScreenWidth * (index + 1) - kScreenWidth * bili, imgV.frame.origin.y, kScreenWidth * bili, height);
        }else{//大于当前页的局左显示
            imgV.frame = CGRectMake(kScreenWidth * index, imgV.frame.origin.y, kScreenWidth * bili, height);
        }
    }
}

- (IBAction)disViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
