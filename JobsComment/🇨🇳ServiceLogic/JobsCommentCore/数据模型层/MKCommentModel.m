//
//  MKCommentModel.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKCommentModel.h"

@implementation MKChildCommentModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

@end

@implementation MKFirstCommentModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"childMutArr" : [MKChildCommentModel class]
    };
}

-(NSInteger)preMax{
    if (_preMax == 0) {
        _preMax = 3;
    }return _preMax;
}

-(NSInteger)loadMoreDataNum{
    if (_loadMoreDataNum == 0) {
        return self.childMutArr.count - self.firstShonNum;//全加载 = 数据库有的 - 默认已经显示的
    }return _loadMoreDataNum;
}

-(NSInteger)firstShonNum{
    return self.childMutArr.count > self.preMax ? self.preMax : self.childMutArr.count;
}

@end

@implementation MKCommentModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"list" : [MKFirstCommentModel class]
    };
}

@end


