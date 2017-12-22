//
//  NNImgScrollView.m
//  ImgsDemo
//
//  Created by Mac on 2017/12/22.
//  Copyright © 2017年 Mac. All rights reserved.
//

//屏幕高度、宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#import "NNImgScrollView.h"
#import "UIImageView+WebCache.h"

@interface NNImgScrollView ()<UIScrollViewDelegate>

@property(nonatomic, assign) CGFloat currentImgHeight;//当前图片高度
@property(nonatomic, assign) NSInteger currentIndex;//当前页面
@property(nonatomic, assign) CGFloat nextImgHeight;//下一个高度
@property(nonatomic, strong) NSMutableArray *imgViews;//所有的图片视图
@property(nonatomic, strong) NSMutableArray *imageHeights;//高度数组


@end

@implementation NNImgScrollView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    self.imgViews = [[NSMutableArray alloc] initWithCapacity:0];
    self.imageHeights = [[NSMutableArray alloc] initWithCapacity:0];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

-(void)setDataImages:(NSArray<NNImageModel> *)dataImages {
    _dataImages = dataImages;
    [self initImageData];
    [self setSubViews];
}

- (void)initImageData {
    
    for (int i = 0; i < self.dataImages.count; i ++) {
        NNImageModel * model = self.dataImages[i];
        CGFloat height = model.imageHeight / (model.imageWidth / kScreenWidth);
        if (i == 0) {
            self.currentImgHeight = height;
        }
        [self.imageHeights addObject:[NSNumber numberWithFloat:height]];
    }
}

- (void)setSubViews {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kScreenWidth, self.currentImgHeight);
    self.contentSize = CGSizeMake(kScreenWidth * self.imageHeights.count, self.currentImgHeight);
    self.pagingEnabled = YES;
    self.delegate = self;
    self.bounces = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < self.imageHeights.count; i ++) {
        UIImageView * img = [[UIImageView alloc] init];
        NNImageModel * model = self.dataImages[i];
        if (model.imageUrl.length > 0) {
            [img sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:self.defaultImageName]];
        }else{
            img.image = [UIImage imageNamed:model.imageName];
        }
        img.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, self.currentImgHeight);
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.clipsToBounds = YES;
        [self addSubview:img];
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
        scrollView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kScreenWidth, self.currentImgHeight);
    }else{//其他
        self.nextImgHeight = [self.imageHeights[self.currentIndex + 1] floatValue];//下一个图片高度
        CGFloat chae = self.nextImgHeight - self.currentImgHeight;//两张图片高度差额（一个屏幕最多两张图）
        scrollView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, kScreenWidth, self.currentImgHeight + chae * pianyizhishu);//差额乘指数加上当前高度得到滑动中的高度
    }
    [self setimgsHeight:scrollView.frame.size.height];
}

//图片高度计算更改
- (void)setimgsHeight:(CGFloat)height {
    //更改ScrollView的contentSize
    self.contentSize = CGSizeMake(kScreenWidth * self.imageHeights.count, height);
    for (UIImageView * imgV in self.imgViews) {//更改每一个图片的位置
        NSInteger index = [self.imgViews indexOfObject:imgV];
        CGFloat bili = height / [self.imageHeights[index] floatValue];
        if (index <= self.currentIndex ) {//小于等于当前页的局右显示
            imgV.frame = CGRectMake(kScreenWidth * (index + 1) - kScreenWidth * bili, 0, kScreenWidth * bili, height);
        }else{//大于当前页的局左显示
            imgV.frame = CGRectMake(kScreenWidth * index, 0, kScreenWidth * bili, height);
        }
    }
}

@end
