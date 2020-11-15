 //
//  JobsCommentCoreVC.h
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import <UIKit/UIKit.h>
#import "PopUpVC.h"
#import "EmptyView.h"
#import "JobsCommentPopUpViewForTVH.h"
#import "InfoTBVCell.h"//显示具体的有用讯息
#import "LoadMoreTBVCell.h"//加载更多
#import "MKCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsCommentCoreVC : PopUpVC

@property(nonatomic,strong)MKCommentModel *commentModel;

@end

NS_ASSUME_NONNULL_END
