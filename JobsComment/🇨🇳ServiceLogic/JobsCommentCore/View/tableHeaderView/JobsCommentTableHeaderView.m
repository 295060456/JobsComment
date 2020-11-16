//
//  JobsCommentTableHeaderView.m
//  JobsComment
//
//  Created by Jobs on 2020/11/16.
//

#import "JobsCommentTableHeaderView.h"

@interface JobsCommentTableHeaderView ()

@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,assign)BOOL isOK;

@property(nonatomic,copy)MKDataBlock jobsCommentTableHeaderViewBlock;

@end

@implementation JobsCommentTableHeaderView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = KLightGrayColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if ([NSString isNullString:self.titleStr]) {
            self.titleStr = @"评论";
        }
        self.cancelBtn.alpha = 1;
        self.titleLab.alpha = 1;
        self.isOK = YES;
    }
}

-(CGRect)makeRect{
    return CGRectMake(0, 0, MAINSCREEN_WIDTH, 50);
}

-(void)actionBlockJobsCommentTableHeaderView:(MKDataBlock)jobsCommentTableHeaderViewBlock{
    self.jobsCommentTableHeaderViewBlock = jobsCommentTableHeaderViewBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        [_cancelBtn setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"删除")
                    forState:UIControlStateNormal];
        @weakify(self)
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"点击了删除按钮");
            if (self.jobsCommentTableHeaderViewBlock) {
                self.jobsCommentTableHeaderViewBlock(x);
            }
        }];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(3);
            make.bottom.equalTo(self).offset(-3);
            make.right.equalTo(self).offset(-3);
            make.width.mas_equalTo(self.mj_h - 6);
        }];
    }return _cancelBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = kBlackColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = self.titleStr;
        _titleLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.right.equalTo(self.cancelBtn.mas_left);
        }];
    }return _titleLab;
}

@end
