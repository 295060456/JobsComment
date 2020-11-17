//
//  JobsCommentConfig.h
//  JobsComment
//
//  Created by Jobs on 2020/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsCommentConfig : NSObject

@property(nonatomic,assign,readonly)CGSize headerImageViewSize;
@property(nonatomic,strong,readonly)UIFont *titleFont;
@property(nonatomic,strong,readonly)UIFont *subTitleFont;
@property(nonatomic,strong,readonly)UIColor *titleCor;
@property(nonatomic,strong,readonly)UIColor *subTitleCor;
@property(nonatomic,assign,readonly)UIColor *bgCor;
@property(nonatomic,assign,readonly)CGFloat cellHeight;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
