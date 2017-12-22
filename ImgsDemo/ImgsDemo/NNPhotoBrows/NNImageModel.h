//
//  NNImageModel.h
//  ImgsDemo
//
//  Created by Mac on 2017/12/22.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNImageModel : NSObject

@property (nonatomic, assign) float imageWidth;
@property (nonatomic, assign) float imageHeight;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, copy) NSString * imageName;

@end
