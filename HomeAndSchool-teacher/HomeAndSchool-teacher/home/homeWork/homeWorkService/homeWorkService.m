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
#define SETIMAGE @"http://localhost:8888/iuu-teacher/index.php/home/homeWork/setImage"

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

+ (void)setImg:(NSArray *)imgs andHomeWorkId:(int)homeWorkId andSubject:(NSString *)sub andSuccess:(void (^)(NSString *))success andFail:(void (^)(NSString *))fail{
    
    if (imgs.count == 0) {
        
        NSLog(@"没有要上传的图片");
        return;
    }
    for (int i = 0; i < imgs.count; i++) {
        
        if (![imgs isKindOfClass:[UIImage class]]) {
            
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
            return;
        }
    }
    UIImage *imagess = [UIImage imageNamed:@"homeWorkBak"];
    NSArray *arrr = @[imagess];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer = [AFJSONResponseSerializer serializer];

    NSNumber *homeworkId = [NSNumber numberWithInt:homeWorkId];
    
    NSDictionary *dic = @{
                          @"classId":homeworkId
                          };

    [manage POST:SETIMAGE parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        int i = 0;
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateStr = [formatter stringFromDate:date];
        
        for (UIImage *img in arrr) {
        
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateStr,i];
            
            NSData *imageData;
        
            imageData = UIImageJPEGRepresentation(img, 1.0f);
        
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@%d",sub,homeWorkId] fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
