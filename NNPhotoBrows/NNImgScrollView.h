//
//  NNImgScrollView.h
//  ImgsDemo
//
//  Created by Mac on 2017/12/22.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNImageModel.h"

@protocol NNImageModel;
@interface NNImgScrollView : UIScrollView

/**
 图片信息数组
 */
@property (nonatomic, strong) NSArray <NNImageModel> * dataImages;

/**
 默认图片
 */
@property (nonatomic, copy) NSString * defaultImageName;
@end
