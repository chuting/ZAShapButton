//
//  ZAShapeButton.m
//  OppleOnline
//
//  Created by zhuoapp on 15/6/3.
//  Copyright (c) 2015年 zhuoapp. All rights reserved.
//

#import "ZAShapeButton.h"


#define PathKey @"path"
#define PositionKey @"position"
#define PathDic(path,position) [NSDictionary dictionaryWithObjectsAndKeys:path,@"path",position,@"position", nil]
#define OffSet 2.5
@interface ZAShapeButton()

@property (nonatomic) NSMutableArray *pathArray;
@end

@implementation ZAShapeButton
@synthesize selectButtonPosition;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */



-(instancetype)initWithFrame:(CGRect)frame ButtonType:(ButtonType)type
{
     self=[super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    buttonType=type;
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(frame), CGRectGetHeight(frame))];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor colorWithRed:159/255.0 green:159/255.0 blue:167/255.0 alpha:1];
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:titleLabel];
       
    self.userInteractionEnabled=YES;
    
    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    longPressGestureRecognizer.minimumPressDuration=0.05;
    [self addGestureRecognizer:longPressGestureRecognizer];
    
    switch (type) {
        case ButtonTypeRect:
            self.image=[UIImage imageNamed:@"virtual_control_rect"] ;
            break;
        case ButtonTypeRoundSingle:
            self.image=[UIImage imageNamed:@"virtual_control_round_single"];
            break;
        case ButtonTypeRound:
            self.image=[UIImage imageNamed:@"virtual_control_round"];
            break;
        case ButtonTypeHPlusAndMin:
            self.image=[UIImage imageNamed:@"virtual_control_h"]  ;
            break;
        case ButtonTypeVPlusAndMin:
             self.image=[UIImage imageNamed:@"virtual_control_v"];
            break;
        default:
            break;
    }
       return self;
}



-(void)setImage:(UIImage *)image
{
    [super setImage:image];
     self.frame=CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), self.image.size.width, self.image.size.height);
    titleLabel.frame=CGRectMake(0, 0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
}
#pragma mark - 设置标题
-(void)setTitle:(NSString *)title
{
    titleLabel.text=title;
}

 
#pragma mark - 设置响应位置
-(void)setResponsePosition:(SelectButtonPosition)position
{
    if (!_pathArray) {
        _pathArray=[[NSMutableArray alloc]init];
    }else{
        [_pathArray removeAllObjects];
    }
    
    if (buttonType==ButtonTypeHPlusAndMin) {
        if (position & SelectButtonPositionLeft) {
              [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionLeft]];
        }
        
        if (position & SelectButtonPositionRight) {
              [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionRight]];
        }
    }
    
    if (buttonType==ButtonTypeVPlusAndMin) {
        if (position & SelectButtonPositionTop) {
            [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionTop]];
        }
        if (position & SelectButtonPositionButtom) {
            [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionButtom]];
        }
    }
    
    if (buttonType==ButtonTypeRound) {
        if (position & SelectButtonPositionTop) {
            [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionTop]];
        }
        if (position & SelectButtonPositionLeft) {
            [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionLeft]];
        }
        if (position & SelectButtonPositionRight) {
            [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionRight]];
        }
        if (position & SelectButtonPositionButtom) {
            [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionButtom]];
        }
        if (position & SelectButtonPositionCenter) {
            [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionCenter]];
        }
    }
}

#pragma mark - 获取路径数组
-(NSMutableArray *)pathArray
{
    if (!_pathArray) {
        _pathArray=[[NSMutableArray alloc]init];
        switch (buttonType) {
            case ButtonTypeHPlusAndMin:
                [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionLeft]];
                [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionRight]];
                break;
            case ButtonTypeVPlusAndMin:
                [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionTop]];
                [_pathArray addObject:[self rectShapWithPosition:SelectButtonPositionButtom]];
                break;
            case ButtonTypeRound:
                [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionLeft]];
                [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionRight]];
                [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionTop]];
                [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionButtom]];
                [_pathArray addObject:[self roundShapWithPosition:SelectButtonPositionCenter]];
                break;
            case ButtonTypeRoundSingle:
                [_pathArray addObject:[self roundShap]];
                break;
            case ButtonTypeRect:
                [_pathArray addObject:[self rectShap]];
                break;
            default:
                break;
        }
        
    }
    return _pathArray;
    
}



#pragma mark - 添加响应事件
-(void)addTarget:(id)target action:(SEL)action forResponseState:(ButtonClickType)state
{
    handel=target;
    switch (state) {
        case ButtonClickTypeLongPress:
            longPressAction=action;
            break;
        case ButtonClickTypeTouchUpInside:
            touchAction=action;
            break;
        default:
            break;
    }
}



#pragma mark -  触摸事件执行
- (void)longPressGesture:(UILongPressGestureRecognizer*)longGesture{
     
    BOOL containsPoint=[self containsPoint:[longPressGestureRecognizer locationInView:self]];
    NSInteger tag = [self indexOfPoint:[longPressGestureRecognizer locationInView:self]];
    
    if (containsPoint) {
        if (!layerArray) {
            layerArray=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in self.pathArray) {
                UIBezierPath *path=[dic objectForKey:PathKey];
                CAShapeLayer *maskLayer = [CAShapeLayer layer];
                maskLayer.path = [path CGPath];
                maskLayer.fillColor = [[UIColor colorWithWhite:0 alpha:0.2] CGColor];
                maskLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
                [self.layer addSublayer:maskLayer];
                [layerArray addObject:maskLayer];
            }
        }
    }
    
    if (longGesture &&(longGesture.state==UIGestureRecognizerStateBegan||longGesture.state==UIGestureRecognizerStateChanged)) {
        if (!containsPoint){
            return;
        }
        if (longGesture.state==UIGestureRecognizerStateBegan) {
            longPressNotComplete=YES;
            if (longPressAction!=nil) {
                //如果有长按执行事件，则初始化timer
                longPressTimer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(longPressTimerOut) userInfo:nil repeats:NO];
            }
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            for (NSInteger i=0; i<layerArray.count; i++) {
                CAShapeLayer * layer=[layerArray objectAtIndex:i];
                if (i==tag) {
                    layer.fillColor=[[UIColor colorWithWhite:0 alpha:0.1] CGColor];
                }else{
                    layer.fillColor=[[UIColor colorWithWhite:0 alpha:0] CGColor];;
                }
            }
        }completion:^(BOOL finished) {
            
        }];
    }
    
    if (longGesture.state==UIGestureRecognizerStateEnded||longGesture.state==UIGestureRecognizerStateCancelled||longGesture==nil) {
       
        [UIView animateWithDuration:0.3 animations:^{
            for (CAShapeLayer *layer in layerArray) {
                layer.fillColor=[[UIColor colorWithWhite:0 alpha:0] CGColor];;
            }
        }];
        
        if (longGesture.state==UIGestureRecognizerStateEnded||longGesture.state==UIGestureRecognizerStateCancelled) {
            
            if (longPressTimer) {
                [longPressTimer invalidate];
            }
        }
    }
 
    if (containsPoint && longGesture.state==UIGestureRecognizerStateEnded&&longPressNotComplete) {
        
        if (handel&&[handel respondsToSelector:touchAction ]) {
            self.selectButtonPosition=[self GetPositonWithTag:tag]; 
            [handel performSelector:touchAction withObject:self afterDelay:0];
        }
    }
       if(containsPoint && longGesture==nil) {
        if (handel&&[handel respondsToSelector:longPressAction ]) {
            NSInteger tag = [self indexOfPoint:[longPressGestureRecognizer locationInView:self]];
            self.selectButtonPosition=[self GetPositonWithTag:tag];
            [handel performSelector:longPressAction withObject:self afterDelay:0];
        }
    }

}


#pragma mark - 长按1.5s后执行
-(void)longPressTimerOut
{
    longPressNotComplete=NO;
    [longPressTimer invalidate];
    [self longPressGesture:nil];
}



#pragma mark - 圆弧贝塞尔曲线
-(NSDictionary *)rectShapWithPosition:(SelectButtonPosition)position{
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    float  offset=OffSet;
    
    float radius=((position==SelectButtonPositionLeft||position==SelectButtonPositionRight)? CGRectGetHeight(self.frame)/2:CGRectGetWidth(self.frame)/2)-offset;
    float height=((position==SelectButtonPositionLeft||position==SelectButtonPositionRight)? CGRectGetWidth(self.frame)/3.0:CGRectGetHeight(self.frame)/3.0)-radius;
    CGRect frame=self.frame;
    CGPoint center = CGPointZero;
    float startAngle = 0;
    float endAngle = 0;
    switch (position) {
        case SelectButtonPositionRight:
            center.x=CGRectGetWidth(frame)-radius-offset;
            center.y=CGRectGetHeight(frame)/2.0;
            startAngle=3/2.0*M_PI;
            endAngle=M_PI/2.0;
            break;
        case SelectButtonPositionLeft:
            center.x= radius+offset;
            center.y=CGRectGetHeight(frame)/2.0;
            startAngle=M_PI/2.0;
            endAngle=3/2.0*M_PI;
            break;
        case SelectButtonPositionTop:
            center.x= CGRectGetWidth(frame)/2;
            center.y=radius+offset;
            startAngle=M_PI;
            endAngle=0;
            break;
        case SelectButtonPositionButtom:
            center.x= CGRectGetWidth(frame)/2;
            center.y=CGRectGetHeight(frame)-radius-offset;
            startAngle=0;
            endAngle=M_PI;
            break;
        default:
            break;
    }
    
    [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CGPoint point = CGPointZero;
       switch (position) {
        case SelectButtonPositionRight:
        case SelectButtonPositionLeft:
            point.x=center.x-height*sin(endAngle);
            point.y=center.y+radius*sin(endAngle);
            break;
        case SelectButtonPositionTop:
        case SelectButtonPositionButtom:
            point.x=center.x+radius *cos(endAngle);
            point.y=center.y+height*cos(endAngle);;
            break;
        default:
            break;
    }
       [bezierPath addLineToPoint:point];
       switch (position) {
        case SelectButtonPositionRight:
        case SelectButtonPositionLeft:
            point.y=point.y-radius*2*sin(endAngle);
            break;
        case SelectButtonPositionTop:
        case SelectButtonPositionButtom:
            point.x=point.x-radius*2*cos(endAngle);
            break;
        default:
            break;
    }
    [bezierPath addLineToPoint:point];
    [bezierPath closePath];
    return PathDic(bezierPath, [NSNumber numberWithInteger:position]);
}

#pragma mark - 圆弧贝塞尔曲线
-(NSDictionary *)roundShapWithPosition:(SelectButtonPosition)position
{
    
    float radius=CGRectGetWidth(self.frame)/2.0-OffSet;
    float width=radius*0.555;
    int positionTag=log2(position);
    
    CGPoint center=CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    if (position==SelectButtonPositionCenter) {
        return [self roundPathWithRadius:(radius-width-OffSet) center:center];
    }
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    float startAngle=M_PI*5/4.0+1/2.0*M_PI*positionTag;
    startAngle=startAngle>2*M_PI?(startAngle-2.0*M_PI):startAngle;
    float endAngle=startAngle+1/2.0*M_PI;
    [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGPoint point;
    point.x=center.x+radius*sin(endAngle);
    point.y=center.x+radius*cos(endAngle);
    [bezierPath addLineToPoint:point];
    [bezierPath addArcWithCenter:center radius:radius-width startAngle:endAngle endAngle:startAngle clockwise:NO];
    
    point.x=center.x+radius*sin(startAngle);
    point.y=center.y+radius*cos(startAngle);
    
    [bezierPath addLineToPoint:point];
    [bezierPath closePath];
    
    return PathDic(bezierPath, [NSNumber numberWithInteger:position]);
   }



#pragma mark - 整圆贝塞尔曲线
-(NSDictionary *)roundShap{

    return [self roundPathWithRadius:(CGRectGetWidth(self.frame)/2.0-OffSet) center:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];

}



#pragma mark -
-(NSDictionary *)roundPathWithRadius:(float)radius  center:(CGPoint)center
{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:center radius:radius startAngle:0 endAngle:2.0*M_PI clockwise:YES];
    [bezierPath closePath];
    
    return PathDic(bezierPath, [NSNumber numberWithInteger:SelectButtonPositionCenter]);
}



#pragma mark - 整圆贝塞尔曲线
-(NSDictionary *)rectShap{
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    float  offset=OffSet;
    
    float radius= CGRectGetHeight(self.frame)/2-offset;
    float width=CGRectGetWidth(self.frame)-2*radius-offset*2;
    CGRect frame=self.frame;
    CGPoint center;
    float startAngle ;
    float endAngle;
    center.x= radius+offset;
    center.y=CGRectGetHeight(frame)/2.0;
    startAngle=M_PI/2.0;
    endAngle=3/2.0*M_PI;
    [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    CGPoint point;
    
    point.x=center.x+width;
    point.y=offset;
    [bezierPath addLineToPoint:point];

    
    center.x=point.x;
    [bezierPath addArcWithCenter:center radius:radius startAngle:endAngle endAngle:startAngle clockwise:YES];
    [bezierPath closePath];
    
     return PathDic(bezierPath, [NSNumber numberWithInteger:SelectButtonPositionCenter]);
}



#pragma mark - 获取获取点在数组的位置
-(NSInteger)indexOfPoint:(CGPoint)point
{
    for (NSDictionary *path in self.pathArray) {
        if ([[path objectForKey:PathKey] containsPoint:point]) {
            return  [self.pathArray indexOfObject:path];
            break;
        }
    }
    return -1;
}




#pragma mark - 获取位置
-(SelectButtonPosition)GetPositonWithTag:(NSInteger)tag
{
    NSDictionary *path=[self.pathArray objectAtIndex:tag];
    return [[path objectForKey:PositionKey] intValue];
       
}


#pragma mark - 点是否在曲线内
-(BOOL)containsPoint:(CGPoint)point
{
    return ([self indexOfPoint:point]==-1?NO:YES);
    
}



@end
