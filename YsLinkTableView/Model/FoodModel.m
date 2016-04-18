//
//  FoodModel.m
//  YsLinkTableView
//
//  Created by weiying on 16/2/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

//KVC字典转模型
+ (instancetype)initWithDict:(NSDictionary *)dict
{
    FoodModel *foodM = [[self alloc] init];
    [foodM setValuesForKeysWithDictionary:dict];
    return foodM;
}

//如果大模型中存在数组，关联数组中子对象
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"foodSubs"]) {
        NSMutableArray *foods = [NSMutableArray array];
        for (NSDictionary *foodSub in value) {
            FoodItemModel *foodItemM = [FoodItemModel initWithDict:foodSub];
            [foods addObject:foodItemM];
        }
        self.foodSubs = foods;
    }else{
        [super setValue:value forKey:key];
    }
}

//如果存在字段不对呀，防止KVC报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end

@implementation FoodItemModel

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    FoodItemModel *foodItemM = [[self alloc] init];
    [foodItemM setValuesForKeysWithDictionary:dict];
    return foodItemM;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end