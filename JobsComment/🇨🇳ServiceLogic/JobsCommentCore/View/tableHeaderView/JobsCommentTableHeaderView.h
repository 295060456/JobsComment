//
//  JobsCommentTableHeaderView.h
//  JobsComment
//
//  Created by Jobs on 2020/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsCommentTableHeaderView : UIView

@property(nonatomic,strong)NSString *titleStr;
-(void)actionBlockJobsCommentTableHeaderView:(MKDataBlock)jobsCommentTableHeaderViewBlock;
-(CGRect)makeRect;

@end

NS_ASSUME_NONNULL_END
