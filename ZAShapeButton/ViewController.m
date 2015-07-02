//
//  ViewController.m
//  ZAShapeButton
//
//  Created by zhuoapp on 15/7/1.
//  Copyright (c) 2015年 zhuoapp. All rights reserved.
//

#import "ViewController.h"
#import "ZAShapeButton.h"

@interface ViewController ()
{


    UILabel *showLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    showLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20,CGRectGetWidth(self.view.frame), 30)];
    showLabel.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    showLabel.textColor=[UIColor grayColor];
    showLabel.textAlignment=NSTextAlignmentCenter;
    showLabel.text=@"暂无点击事件";
    [self.view addSubview:showLabel];
    
    
    
    NSArray *titleArray=@[@"OK",@"",@"",@"音量",@"音量"];
    
    
    float height=CGRectGetMaxY(showLabel.frame)+20;
    for (int i=0; i<5; i++) {
        
        
        
        //1-5分别为 圆形五个按钮，单个圆形按钮，圆角按钮，竖加减，横加减
        
     
        
        
        ZAShapeButton *buttonView=[[ZAShapeButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50) ButtonType:i];
        [buttonView addTarget:self action:@selector(buttonClick:) forResponseState:ButtonClickType_TouchUpInside];
        [buttonView addTarget:self action:@selector(longPressButtonClick:) forResponseState:ButtonClickType_LongPress];
        [self.view addSubview:buttonView];
        
        
      
     
    
        
        CGPoint center;
        UIImage *image;
        
    
        switch (i) {
            case 0:
                //  圆形五个按钮 上下左右 中心
                
                center=CGPointMake(CGRectGetMidX(self.view.frame), height+CGRectGetHeight(buttonView.frame)/2);
                
                break;
                
                break;
            case 1:
                //  单个圆形按钮  只响应 SelectButtonPosition_Center
                
                
                image=[UIImage imageNamed:@"virtual_control_switch"];
                center=CGPointMake(CGRectGetMidX(self.view.frame)/2.0, height+image.size.width/2);
                
                
                break;
            case 2:
                // 圆角按钮 只响应 SelectButtonPosition_Center
                image=[UIImage imageNamed:@"virtual_control_number"];
                center=CGPointMake(CGRectGetMidX(self.view.frame)/2.0, height+image.size.height/2);
            
                
                break;
            case 3:
                // 竖加减  只响应 SelectButtonPosition_Buttom  SelectButtonPosition_Top，
                
                center=CGPointMake(CGRectGetMidX(self.view.frame)/2.0*3, height-CGRectGetHeight(buttonView.frame)/2-30);
            
                
                break;
            case 4:
                // 横加减   只响应 SelectButtonPosition_Right  SelectButtonPosition_Left，
                
                
                center=CGPointMake(CGRectGetMidX(self.view.frame), height+CGRectGetHeight(buttonView.frame)/2);
          
                
                break;
                
                
            default:
                break;
        }

        
      
        if (image) {
            
            [buttonView setImage:image];
        }
        
        [buttonView setTitle:[titleArray objectAtIndex:i]];
        buttonView.center=center;
        buttonView.tag=i;
        height=CGRectGetMaxY(buttonView.frame)+30;
   
        
    }
    
}



#pragma mark -  按钮单击事件
-(void)buttonClick:(ZAShapeButton *)button
{
    
  
    NSString *string=[NSString stringWithFormat:@"单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’",button.tag,[self getSelectPartStringWithButtonView:button ]];
    
    showLabel.text=string;
// 
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
    
}



#pragma mark -  按钮长按事件
-(void)longPressButtonClick:(ZAShapeButton *)button
{
 

    NSString *string=[NSString stringWithFormat:@"长按事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’",button.tag,[self getSelectPartStringWithButtonView:button ]];
    
    
      showLabel.text=string;
    
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    

}


#pragma mark - 获取选中位置
-(NSString *)getSelectPartStringWithButtonView:(ZAShapeButton *)button
{
    NSString *partString;
    
    
    switch (button.selectButtonPosition) {
        case SelectButtonPosition_Top:
            
            partString=@"上";
            break;
        case SelectButtonPosition_Buttom:
            partString=@"下";
            break;
        case SelectButtonPosition_Center:
            
            partString=@"中";
            break;
        case SelectButtonPosition_Left:
            partString=@"左";
            break;
        case SelectButtonPosition_Right:
            partString=@"右";
            break;
        default:
            break;
    }

    
    return partString;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
