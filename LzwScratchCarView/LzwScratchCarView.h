//
//  LzwScratchCarView.h
//  LzwScratchCarDemo
//
//  Created by pc37 on 2017/9/18.
//  Copyright © 2017年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LzwScratchCompletion)(NSDictionary *infoDict);

@interface LzwScratchCarView : UIView
//要刮开的底图
@property (nonatomic, strong) UIImage *image;
//涂层图片
@property (nonatomic, strong) UIImage *surfaceImage;
//图层是否被刮开
@property (nonatomic, assign, readonly, getter=isOpen) BOOL open;
//刮出后的回调
@property (nonatomic, strong) LzwScratchCompletion completion;
//储存结果信息
@property (nonatomic, strong) NSDictionary *infoDict;
//初始化
- (id)initWithFrame:(CGRect)frame;
//在刮一次
- (void)resetScratchCompletionCar;

@end
