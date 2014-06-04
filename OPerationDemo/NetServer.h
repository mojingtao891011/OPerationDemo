//
//  NetServer.h
//  iSpace
//
//  Created by bear on 14-6-3.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^handleFininshBlock) (id); //处理完成代码块
typedef void(^handleFailBlock) (id); //处理完成代码块

@interface NetServer : NSObject
{
    NSOperationQueue *_queue ;
}
@property(nonatomic , copy)handleFininshBlock fininshBlock ;
@property(nonatomic , copy)handleFailBlock failBlock ;

+(NetServer*)shareManager ;

//向网络提交数据
-(void)submitNeedCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue needFininshBlock:(handleFininshBlock)submitBlock needFailBlock:(handleFailBlock)failBlock;

//向网络获取数据
-(void)getNeedCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue needFininshBlock:(handleFininshBlock)getBlock needFailBlock:(handleFailBlock)failBlock;

@end
