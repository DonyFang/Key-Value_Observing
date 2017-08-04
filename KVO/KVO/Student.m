//
//  Student.m
//  KVO
//
//  Created by 方冬冬 on 2017/8/4.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "Student.h"

@implementation Student

/*
 
 之前说的都是自动通知，当添加了观察者后，只要发生改变就会自动通知观察者，但有时候我们并不是什么改变都希望得到通知，或者有时候是希望变化到什么情况后再通知，这就需要改变通知的机制。默认的实现模式为自动通知的模式，要自定义何时进行通知，就要改成手动通知的模式。
 
 要改成手动通知，首先要在被观察者的模型中重写一个方法 automaticallyNotifiesObserversForKey ：
 
 */
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    BOOL automic = NO;
    
    if ([key isEqualToString:@"score"]) {
        automic = NO;
    }else{
       automic =  [super automaticallyNotifiesObserversForKey:key];
    
    }

    return automic;
}
// 提升性能的手动发送  你需要重写你想手动发送通知属性的setter方法，然后在属性值改变之前和之后分别调用willChangeValueForKey:和didChangeValueForKey:方法
- (void)setScore:(NSString *)score{
    if (![_score isEqualToString:score]) {
        [self willChangeValueForKey:@"score"];
        
        _score = score;
        
        [self didChangeValueForKey:@"score"];
    }
}
@end
