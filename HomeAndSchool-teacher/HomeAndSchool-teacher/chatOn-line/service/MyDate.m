//
//  MyDate.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyDate.h"

#import "AFNetworking.h"

#import<CommonCrypto/CommonDigest.h>

@implementation MyDate



+ (NSString *) sha1:(NSString *)input
{

    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


+ (void)Register:(NSString *)userId andSuccess:(void (^)(NSString *))success{
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString *url=@"https://api.cn.ronghub.com/user/getToken.json";
    
    
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%ld",(NSInteger)[NSDate timeIntervalSinceReferenceDate]];
    NSString *appKey = @"m7ua80gbu9qcm";
    NSString *appSec = @"5uLGLBRobTbQP";
    NSString *sha1 = [self sha1:[ NSString stringWithFormat:@"%@%@%@",appSec,nonce,timestamp]];
    [manager.requestSerializer setValue:appKey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:sha1 forHTTPHeaderField:@"Signature"];
    
    NSDictionary *userMessage = @{@"userId":userId};
    
    
    [manager POST:url parameters:userMessage progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSString *token=responseObject[@"token"];
        
        success(token);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"shibai");
    }];
    
    
    
}


+ (void)CreatGroup:(NSDictionary *)groupInfo  andSuccess:(void (^)(NSString *tips))success{

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSString *url=@"https://api.cn.ronghub.com/group/create.json";
    
    
    NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
    NSString * timestamp = [[NSString alloc] initWithFormat:@"%ld",(NSInteger)[NSDate timeIntervalSinceReferenceDate]];
    NSString *appKey = @"m7ua80gbu9qcm";
    NSString *appSec = @"5uLGLBRobTbQP";
    NSString *sha1 = [self sha1:[ NSString stringWithFormat:@"%@%@%@",appSec,nonce,timestamp]];
    [manager.requestSerializer setValue:appKey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:sha1 forHTTPHeaderField:@"Signature"];
    
    
    
    [manager POST:url parameters:groupInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSString *tips=@"创建成功";
        
        
        success(tips);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"shibai");
    }];
    

}







@end
