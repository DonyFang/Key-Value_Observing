//
//  SecondViewController.m
//  KVO
//
//  Created by 方冬冬 on 2017/8/4.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "SecondViewController.h"
#import "Student.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *show;

@property(nonatomic,strong)Student *studentModel;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"手动发布通知";
    
    self.studentModel  = [[Student alloc] init];

    [self.studentModel addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    
}

/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if([keyPath isEqualToString:@"score"] && object == self.studentModel)
    {
        // 响应变化处理：UI更新（label文本改变）
        self.show.text = [NSString stringWithFormat:@"当前的num值为：%@",[change valueForKey:@"new"]];
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)change:(id)sender {
    [self willChangeValueForKey:@"score"];// 改为手动通知
    [self.studentModel setValue:@"99.0" forKey:@"score"];
    [self didChangeValueForKey:@"score"];// 改为手动通知
}

@end
