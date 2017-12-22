//
//  ImagesShowViewController.h
//  RuiYang
//
//  Created by Mac on 2017/12/21.
//  Copyright © 2017年 ruiyang. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface ImagesShowViewController : UIViewController

@property(nonatomic, strong) NSMutableArray *imageArray;//本地图片数组
@property(nonatomic, strong) NSMutableArray *imageUrlArray;//网络图片数组
@property(nonatomic, strong) NSMutableArray *imageHeights;//高度数组

@end
