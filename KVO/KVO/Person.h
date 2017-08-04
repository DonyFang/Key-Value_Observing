//
//  Person.h
//  KVO
//
//  Created by 方冬冬 on 2017/8/3.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,assign)NSInteger  *num;


@property(nonatomic,readwrite,copy)NSString *name;

@end
