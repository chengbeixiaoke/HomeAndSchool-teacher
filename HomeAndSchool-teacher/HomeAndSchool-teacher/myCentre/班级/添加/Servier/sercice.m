//
//  sercice.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "sercice.h"

#import "AFNetworking.h"
@implementation sercice


+(void)GETRequiceAFNetworkingWithURL:(NSString *)url parameters:(NSMutableDictionary *)dic  successHUDTitle:(NSString *)title faileHUDTitle:(NSString *)faileTitle   sendMessage:(void (^)(NSDictionary *))success{
   
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%d",[responseObject[@"error_code"] intValue]);
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"jiazaishibai");
    }];
    
    
    
}

+(void)POSTRequiceAFNetworkingWithURL:(NSString *)url parameters:(NSMutableDictionary *)dic  successHUDTitle:(NSString *)title faileHUDTitle:(NSString *)faileTitle   sendMessage:(void (^)(NSDictionary *))success{
    
    [[AFHTTPSessionManager manager] POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
     
        success(responseObject);
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    
    }];

    
    
}

@end
