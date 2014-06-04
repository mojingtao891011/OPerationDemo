//
//  HandleRequestResult.h
//  OPerationDemo
//
//  Created by bear on 14-6-4.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <Foundation/Foundation.h>

//处理提交数据的代码块
typedef void(^handleSubmitBlock) (id);
//处理获取数据的代码块
typedef void(^handleGetBlock) (id , NSString*);

@interface HandleRequestResult : NSObject

@property(nonatomic , copy)handleSubmitBlock handleSubmitBlock ;
@property(nonatomic , copy)handleGetBlock handleGetBlock ;

+(HandleRequestResult*)shareManager;
- (void)HandleData ;

@end
