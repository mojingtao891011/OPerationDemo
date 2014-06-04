//
//  NetServer.m
//  iSpace
//
//  Created by bear on 14-6-3.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "NetServer.h"
#import "URLOperation.h"

@implementation NetServer
+(NetServer*)shareManager
{
    static NetServer  *shareManager = nil ;
    static dispatch_once_t once ;
    dispatch_once(&once , ^{
        shareManager = [[self alloc]init ];
    });
    return shareManager ;
}
- (void)_initOperation:(NSMutableDictionary*)param andCommand:(NSString*)command
{
    
    _queue = [[NSOperationQueue alloc]init];
    URLOperation *operation = [[URLOperation alloc]initWithParam:param andCommand:command];
    [_queue addOperation:operation];
}
//向网络提交数据
-(void)submitNeedCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue needFininshBlock:(handleFininshBlock)submitBlock needFailBlock:(handleFailBlock)failBlock
{
    //请求头
    NSMutableArray *headKey = [NSMutableArray arrayWithObjects:@"flag" , @"protocol" , @"sequence" , @"timestamp" , @"command" , @"user_id" ,nil] ;
    NSMutableArray *headValue = [NSMutableArray arrayWithObjects:@"0" , @"1" , @"0" , @"0", command , userId , nil] ;
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headKey];
    
    //请求体、把请求体的headKey和headValue装进字典里
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyArrValue forKeys:bobyArrkey];
    
    //把请求体与 请求头装进字典里
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;
    
    [self _initOperation:Dict andCommand:@"0"];
    
    self.fininshBlock = ^(id handleResult){
        submitBlock(handleResult);
    };
    self.failBlock = ^(id failResult){
        failBlock(failResult);
    };
}
//向网络获取数据
-(void)getNeedCommand:(NSString*)command andNeedUserId:(NSString*)userId AndNeedBobyArrKey:(NSArray*)bobyArrkey andNeedBobyArrValue:(NSArray*)bobyArrValue needFininshBlock:(handleFininshBlock)getBlock needFailBlock:(handleFailBlock)failBlock
{
    //请求头
    NSMutableArray *headKey = [NSMutableArray arrayWithObjects:@"flag" , @"protocol" , @"sequence" , @"timestamp" , @"command" , @"user_id" ,nil] ;
    NSMutableArray *headValue = [NSMutableArray arrayWithObjects:@"0" , @"1" , @"0" , @"0", command , userId , nil] ;
    NSMutableDictionary *headDic =[NSMutableDictionary dictionaryWithObjects:headValue forKeys:headKey];
    
    //请求体、把请求体的headKey和headValue装进字典里
    NSMutableDictionary *bobyDic =[NSMutableDictionary dictionaryWithObjects:bobyArrValue forKeys:bobyArrkey];
    
    //把请求体与 请求头装进字典里
    NSMutableDictionary *Dict =[[NSMutableDictionary alloc]init];
    [Dict setObject:headDic forKey:@"message_head"] ;
    [Dict setObject:bobyDic forKey:@"message_body"] ;
    
    [self _initOperation:Dict andCommand:command];
    
    self.fininshBlock = ^(id handleResult){
        getBlock(handleResult);
    };
    self.failBlock = ^(id failResult){
        failBlock(failResult);
    };
   
}
@end
