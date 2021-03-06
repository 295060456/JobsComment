//
//  JobsCommentConfig.m
//  JobsComment
//
//  Created by Jobs on 2020/11/17.
//

#import "JobsCommentConfig.h"

@interface JobsCommentConfig ()

@property(nonatomic,assign)CGSize headerImageViewSize;
@property(nonatomic,strong)UIFont *titleFont;
@property(nonatomic,strong)UIFont *subTitleFont;
@property(nonatomic,strong)UIColor *titleCor;
@property(nonatomic,strong)UIColor *subTitleCor;
@property(nonatomic,assign)UIColor *bgCor;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGFloat secondLevelCommentOffset;

@end

@implementation JobsCommentConfig

static JobsCommentConfig *static_jobsCommentConfig = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_jobsCommentConfig) {
            static_jobsCommentConfig = JobsCommentConfig.new;
        }
    }return static_jobsCommentConfig;
}

#pragma mark —— lazyload
-(CGSize)headerImageViewSize{
    return CGSizeMake(34, 34);
}

-(UIFont *)titleFont{
    return kFontSize(13);
}

-(UIFont *)subTitleFont{
    return kFontSize(15);
}

-(UIColor *)titleCor{
    return COLOR_RGBA(131, 145, 175, 1);
}

-(UIColor *)subTitleCor{
    return kBlackColor;
}

-(UIColor *)bgCor{
    return kWhiteColor;
}

-(CGFloat)cellHeight{
    return 55;
}

-(CGFloat)secondLevelCommentOffset{
    return 50;
}

@end
