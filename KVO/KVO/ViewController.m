//
//  ViewController.m
//  KVO
//
//  Created by 方冬冬 on 2017/8/3.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "SecondViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@property(nonatomic,readwrite,strong)Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    KVO的底层实现，好吧也是能秒杀的，就是动态的创建一个派生类，在派生类里实现监听。
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
//    KVO (Key-Value Observing) 是Cocoa提供的一种基于KVC的机制，允许一个对象去监听另一个对象的某个属性，当该属性改变时系统会去通知监听的对象(不是被监听的对象)。
//    
//    上面那个例子如果用KVO实现的话，大概就是，用Person类的一个对象去监听Account类的一个对象的属性，然后当Account类对象的相应属性改变时，Person类的对象就会收到通知。这也是iOS种观察者模式的一种实现方式。
//    
//    也就是说，一般情况下，任何一个对象可以监听任何一个对象（当然也包括自己本身）的任意属性，然后在其属性变化后收到通知。

    
//    那么KVO怎么用呢？KVO的使用步骤主要分为3步：添加监听，接收通知和移除监听。
    
    
    self.person = [[Person alloc] init];
    
    //    [self.person setValue:@"xiaoming" forKey:@"name"];    [self.person setValue:@"Savings" forKeyPath:@"name"];

    
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    //  self.person_kvo
}

- (IBAction)changeValue:(id)sender {
    
    
//    [self.person setValue:@"Savings" forKeyPath:@"name"];
    
    static NSInteger i = 0;
    self.person.name = [NSString stringWithFormat:@"%ld",i ++];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if([keyPath isEqualToString:@"name"] && object == self.person)
    {
        // 响应变化处理：UI更新（label文本改变）
        self.showLabel.text = [NSString stringWithFormat:@"当前的num值为：%@",[change valueForKey:@"new"]];
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
    }
}
-(void)dealloc{
    [self.person removeObserver:self forKeyPath:@"name"];//移除监听
    //[super dealloc];//注意启用了ARC，此处不需要调用
}

- (IBAction)nextController:(id)sender {
    
    SecondViewController *Second = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:Second animated:YES];
}
@end
