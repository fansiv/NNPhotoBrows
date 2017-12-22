//
//  ViewController.m
//  ImgsDemo
//
//  Created by Mac on 2017/12/21.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "NNPhotoBrows.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray * arrimg = @[
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
    
    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < 10; i ++) {//本地
        NNImageModel * model = [[NNImageModel alloc] init];
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        model.imageName = [NSString stringWithFormat:@"%d.jpg",i+1];
        model.imageWidth = image.size.width;
        model.imageHeight = image.size.height;
        [arr addObject:model];
    }
    
    for (int i = 0; i < 8; i ++) {//网络
        NNImageModel * model = [[NNImageModel alloc] init];
        NSArray * imgSize = [arrhs[i] componentsSeparatedByString:@"×"];
        model.imageUrl = arrimg[i];
        model.imageWidth = [imgSize.firstObject floatValue];
        model.imageHeight = [imgSize.lastObject floatValue];
        [arr addObject:model];
    }
    
    
    
    NNImgScrollView * imgScrollView = [[NNImgScrollView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
    imgScrollView.defaultImageName = @"moren";
    imgScrollView.dataImages = (NSArray <NNImageModel> *)arr;
    [self.view addSubview:imgScrollView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)pushViewController:(id)sender {
//
//    ImagesShowViewController  * imgsShowVs = [[ImagesShowViewController alloc] initWithNibName:@"ImagesShowViewController" bundle:nil];
//    [self presentViewController:imgsShowVs animated:YES completion:^{
//
//    }];
//
//}

@end
