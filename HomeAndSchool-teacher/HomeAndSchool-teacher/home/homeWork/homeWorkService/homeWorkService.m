//
//  homeWorkService.m
//  HomeAndSchool-teacher
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "homeWorkService.h"
#import "AFNetworking.h"
#define HOMEWORK_URL @"http://localhost:8888/iuu-teacher/index.php/home/homeWork/lookHomework"
#define SETHOMEWORK @"http://localhost:8888/iuu-teacher/index.php/home/homeWork/setHomework"

@implementation homeWorkService

+ (void)requestHomeWork:(NSString *)subject andWithClass:(int)classId andWithSuccess:(void (^)(NSArray *))success andWithFail:(void (^)(NSString *))fail{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *sub = [subject stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *urlPath = [NSString stringWithFormat:@"%@?subject=%@&class=%d",HOMEWORK_URL,sub,classId];
    
    [manage GET:urlPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic = responseObject;
        
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:0];
        tmpArr = [dic objectForKey:@"data"];
        
        NSMutableArray *homeWorkData = [NSMutableArray arrayWithCapacity:0];
        
        if ([dic allKeys].count > 0) {
            
        if (tmpArr.count > 0) {
            
        for (int i = 0; i < tmpArr.count; i ++) {
            
            NSMutableDictionary *homeWorkDic = [NSMutableDictionary dictionaryWithCapacity:0];
            
            [homeWorkDic setObject:[tmpArr[i] objectForKey:@"homework_time"] forKey:@"time"];
            
            NSString *ContentString =[tmpArr[i] objectForKey:@"homework_content"];
            //从字符#中分隔成n个元素的数组
            NSArray *homeWorkArr = [ContentString componentsSeparatedByString:@"#"];
            [homeWorkDic setObject:homeWorkArr forKey:@"content"];
            
            NSArray *imageArr = @[@"bakImage",@"bakImage",@"bakImage",@"bakImage",@"bakImage"];
            
            
            [homeWorkDic setObject:imageArr forKey:@"image"];
            [homeWorkDic setObject:[tmpArr[i] objectForKey:@"homework_id"] forKey:@"homeWorkId"];
            
            [homeWorkData addObject:homeWorkDic];
        }
                        
            success(homeWorkData);
                        
        }else{
            
            
            success(homeWorkData);
            
        }
        
        }else{
            fail(@"请求失败");
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

+ (void)setHomeWorkSubject:(NSString *)subject andWithClass:(int)classId andTeacherId:(int)teacherId andHWContent:(NSString *)hwContent andTime:(NSString *)time andWithSuccess:(void (^)(NSString *success))success andWithFail:(void (^)(NSString *fail))fail{
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSNumber *a = [NSNumber numberWithInt:classId];
    NSNumber *b = [NSNumber numberWithInt:teacherId];
    NSDictionary *dic = @{
                          @"teacherid":b,
                          @"class":a,
                          @"subject":subject,
                          @"content":hwContent,
                          @"time":time
                          };
    [manage POST:SETHOMEWORK parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *tmpdic = responseObject;
        NSString *a = [tmpdic objectForKey:@"data"];
        
        success(a);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(@"失败");
        
    }];
}

//*  @param url                 网络请求地址
//*  @param images              要上传的图片数组（注意数组内容需是图片）
//*  @param parameter           图片数组对应的参数
//*  @param parameters          其他参数字典
//*  @param ratio               图片的压缩比例（0.0~1.0之间）
//*  @param succeedBlock        成功的回调
//*  @param failedBlock         失败的回调
//*  @param uploadProgressBlock 上传进度的回调
//*/
//+(void)startMultiPartUploadTaskWithURL:(NSString *)url
//                           imagesArray:(NSArray *)images
//                     parameterOfimages:(NSString *)parameter
//                        parametersDict:(NSDictionary *)parameters
//                      compressionRatio:(float)ratio
//                          succeedBlock:(void(^)(id operation, id responseObject))succeedBlock
//                           failedBlock:(void(^)(id operation, NSError *error))failedBlock
//                   uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock;
//
//实现：
//+(void)startMultiPartUploadTaskWithURL:(NSString *)url
//                           imagesArray:(NSArray *)images
//                     parameterOfimages:(NSString *)parameter
//                        parametersDict:(NSDictionary *)parameters
//                      compressionRatio:(float)ratio
//                          succeedBlock:(void (^)(id, id))succeedBlock
//                           failedBlock:(void (^)(id, NSError *))failedBlock
//                   uploadProgressBlock:(void (^)(float, long long, long long))uploadProgressBlock{
//    
//    if (images.count == 0) {
//        NSLog(@"上传内容没有包含图片");
//        return;
//    }
//    for (int i = 0; i < images.count; i++) {
//        if (![images isKindOfClass:[UIImage class]]) {
//            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
//            return;
//        }
//    }
//    
//    AFHTTPRequestOperation *operation = [[self sharedOperation].operationManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        int i = 0;
//        //根据当前系统时间生成图片名称
//        NSDate *date = [NSDate date];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy年MM月dd日"];
//        NSString *dateString = [formatter stringFromDate:date];
//        
//        for (UIImage *image in images) {
//            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
//            NSData *imageData;
//            if (ratio > 0.0f && ratio < 1.0f) {
//                imageData = UIImageJPEGRepresentation(image, ratio);
//            }else{
//                imageData = UIImageJPEGRepresentation(image, 1.0f);
//            }
//            
//            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//        }
//        
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        succeedBlock(operation,responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//        failedBlock(operation,error);
//        
//    }];
//    
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        CGFloat percent = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
//        uploadProgressBlock(percent,totalBytesWritten,totalBytesExpectedToWrite);
//    }];
//    
//}

@end
