//
//  JobsCommentCoreVC+VM.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "JobsCommentCoreVC+VM.h"

@implementation JobsCommentCoreVC (VM)
//装载本地假数据
-(void)loadData{
    NSDictionary *dic = [NSString readLocalFileWithName:@"CommentData"];
    MKCommentModel *mjModel = [MKCommentModel mj_objectWithKeyValues:dic[@"data"]];
    
    MKCommentModel *yyModel = [MKCommentModel yy_modelWithDictionary:dic[@"data"]];
    
    NSLog(@"");
//
}

@end
