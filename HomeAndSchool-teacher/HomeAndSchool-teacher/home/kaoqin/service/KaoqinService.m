//
//  KaoqinService.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/30.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "KaoqinService.h"

#import "Header.h"

#import "AFNetworking.h"

@implementation KaoqinService

+ (void)kaoqin0:(NSDictionary *)dic andSuccess:(void (^)(NSArray *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:KAOQIN0 parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber *code = responseObject[@"code"];
        
        if (code.intValue == 200) {
            
            success(responseObject[@"data"]);
        }else{
            NSArray *arr1;
            success(arr1);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------");
    }];
    
}

+ (void)class0:(NSDictionary *)dic andSuccess:(void (^)(NSArray *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:CLASS parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber *code = responseObject[@"code"];
        
        if (code.intValue == 200) {
            NSArray *arr0 = responseObject[@"data"];
            NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:0];
            for (int i = 0; i < arr0.count; i++) {
                [mutArr addObject:arr0[i][@"classname"]];
            }
            success(mutArr);
        }else{
            NSArray *arr1;
            success(arr1);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
