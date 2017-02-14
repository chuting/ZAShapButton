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
    ButtonType_Round=0,
    /**
     *  单个圆形按钮  只响应 SelectButtonPosition_Center
     */
    ButtonType_Round_Single,
    /**
     *  圆角按钮 只响应 SelectButtonPosition_Center
     */
    ButtonType_Rect,
    /**
     *  竖加减  只响应 SelectButtonPosition_Buttom  SelectButtonPosition_Top，
     */
    ButtonType_V_PlusAndMin,
    
    /**
     *  横加减   只响应 SelectButtonPosition_Right  SelectButtonPosition_Left，
     */
    ButtonType_H_PlusAndMin,
    
}ButtonType;




typedef enum ButtonClickType
{

    //手势抬起响应 
    ButtonClickType_TouchUpInside=0,
    
    //长按0.5s响应
    ButtonClickType_LongPress,


}ButtonClickType;



typedef enum SelectButtonPosition{
    
    SelectButtonPosition_Top =1,
    SelectButtonPosition_Right =1<<1 ,
    SelectButtonPosition_Buttom =1<<2 ,
    SelectButtonPosition_Left =1<<3,
    SelectButtonPosition_Center =1<<4,
    
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
