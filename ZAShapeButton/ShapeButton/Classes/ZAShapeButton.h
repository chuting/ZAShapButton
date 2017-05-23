//
//  ZAShapeButton.h
//  OppleOnline
//
//  Created by zhuoapp on 15/6/3.
//  Copyright (c) 2015年 zhuoapp. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum ButtonType{

    /**
     *  圆形五个按钮 上下左右 中心
     */
    ButtonTypeRound=0,
    /**
     *  单个圆形按钮  只响应 SelectButtonPosition_Center
     */
    ButtonTypeRoundSingle,
    /**
     *  圆角按钮 只响应 SelectButtonPosition_Center
     */
    ButtonTypeRect,
    /**
     *  竖加减  只响应 SelectButtonPosition_Buttom  SelectButtonPosition_Top，
     */
    ButtonTypeVPlusAndMin,
    
    /**
     *  横加减   只响应 SelectButtonPosition_Right  SelectButtonPosition_Left，
     */
    ButtonTypeHPlusAndMin,
    
}ButtonType;




typedef enum ButtonClickType
{

    //手势抬起响应 
    ButtonClickTypeTouchUpInside=0,
    
    //长按0.5s响应
    ButtonClickTypeLongPress,


}ButtonClickType;



typedef enum SelectButtonPosition{
    
    SelectButtonPositionTop =1,
    SelectButtonPositionRight =1<<1 ,
    SelectButtonPositionButtom =1<<2 ,
    SelectButtonPositionLeft =1<<3,
    SelectButtonPositionCenter =1<<4,
    
}SelectButtonPosition;

@interface ZAShapeButton : UIImageView
{

    
//    NSArray *pathArray;
    NSMutableArray *layerArray;
    SEL  touchAction;
    SEL  longPressAction;
    id  handel;
    
    UIGestureRecognizerState responseState;
    
    
    ButtonType buttonType;
     
    UILabel *titleLabel;
    
    
    NSTimer *longPressTimer;


    UILongPressGestureRecognizer *longPressGestureRecognizer;
    
    
    //长按手势未执行
    BOOL longPressNotComplete ;
}

/**
 *  获取选中位置
 */
@property (nonatomic) enum SelectButtonPosition selectButtonPosition;


/**
 *  初始化button
 *
 *  @param frame <#frame description#>
 *  @param type  button 类型
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame ButtonType:(ButtonType)type;


-(void)addTarget:(id)target action:(SEL)action forResponseState:(ButtonClickType)state;


/**
 *  设置响应位置，
 *
 *  @param position 可以传多个参数
 */
-(void)setResponsePosition:(SelectButtonPosition)position;


-(void)setTitle:(NSString *)title;

@end
