//
//  LzwScratchCarView.m
//  LzwScratchCarDemo
//
//  Created by pc37 on 2017/9/18.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "LzwScratchCarView.h"

@interface LzwScratchCarView ()

@property (nonatomic, strong) UIImageView *surfaceImageView;
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGMutablePathRef path;
@property (nonatomic, assign, getter=isOpen) BOOL open;

@end

@implementation LzwScratchCarView

-(void)dealloc
{
    if (self.path) {
        CGPathRelease(self.path);
    }
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews
{
    //最上面的灰色图片
    self.surfaceImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _surfaceImageView.image = [self colorWithImage:[UIColor darkGrayColor]];
    [self addSubview:_surfaceImageView];
    
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = self.bounds;
    [self.layer addSublayer:_imageLayer];
    
    self.shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    _shapeLayer.lineWidth = 30.f;
    _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    _shapeLayer.fillColor = nil;
    [self.layer addSublayer:_shapeLayer];
    _imageLayer.mask = _shapeLayer;
    self.path = CGPathCreateMutable();
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (!self.isOpen) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGPathMoveToPoint(self.path, NULL, point.x, point.y);
        CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (!self.isOpen) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
        CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (!self.isOpen) {
        [self checkIsOpen];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (!self.isOpen) {
        [self checkIsOpen];
    }
}
- (void)checkIsOpen
{
    CGRect rect = CGPathGetPathBoundingBox(self.path);
    NSArray *pointsArray = [self getAllPointsAppay];
    for (NSValue *value in pointsArray) {
        CGPoint point = [value CGPointValue];
        if (!CGRectContainsPoint(rect, point)) {
            return;
        }
    }
    NSLog(@"完成");
    self.open = YES;
    self.imageLayer.mask = NULL;
    if (self.completion) {
        self.completion(self.infoDict);
    }
}
- (NSArray *)getAllPointsAppay
{
    NSMutableArray *array = [NSMutableArray array];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGPoint topPoint = CGPointMake(width / 2, height / 6);
    CGPoint leftPoint = CGPointMake(width / 6, height / 2);
    CGPoint bottomPoint = CGPointMake(width / 2, height - height / 6);
    CGPoint rightPoint = CGPointMake(width - width / 6, height / 2);
    [array addObject:[NSValue valueWithCGPoint:topPoint]];
    [array addObject:[NSValue valueWithCGPoint:leftPoint]];
    [array addObject:[NSValue valueWithCGPoint:bottomPoint]];
    [array addObject:[NSValue valueWithCGPoint:rightPoint]];
    return array;
}
-(void)resetScratchCompletionCar
{
    if (self.path) {
        CGPathRelease(self.path);
    }
    self.open = NO;
    self.path = CGPathCreateMutable();
    self.shapeLayer.path = NULL;
    self.imageLayer.mask = self.shapeLayer;
}

- (UIImage *)colorWithImage:(UIColor *)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageLayer.contents = (id)image.CGImage;
}
-(void)setSurfaceImage:(UIImage *)surfaceImage
{
    _surfaceImage = surfaceImage;
    self.surfaceImageView.image = surfaceImage;
}

@end
