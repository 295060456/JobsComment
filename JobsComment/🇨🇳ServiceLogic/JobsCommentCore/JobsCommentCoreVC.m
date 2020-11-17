//
//  JobsCommentCoreVC.m
//  JobsComment
//
//  Created by Jobs on 2020/11/15.
//

#import "JobsCommentCoreVC.h"
#import "JobsCommentCoreVC+VM.h"

@interface JobsCommentCoreVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *cancelBtn;

@end

@implementation JobsCommentCoreVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_navTitle = @"评论";
    self.gk_navTitleColor = kBlackColor;
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelBtn];
    self.gk_navBackgroundColor = KGreenColor;

    [self hideNavLine];
    NSLog(@"self.gk_navigationBar = %@",self.gk_navigationBar);
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.alpha = 1;
    NSLog(@"self.gk_navigationBar = %@",self.gk_navigationBar);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"");
    self.gk_navigationBar.mj_h -= GK_NAVBAR_HEIGHT;
    [self.gk_navigationBar layoutSubviews];
    NSLog(@"self.gk_navigationBar = %@",self.gk_navigationBar);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:LoadMoreTBVCell.class]) {//加载更多
//        MKFirstCommentModel *firstCommentModel = self.firstCommentModelMutArr[indexPath.section];
//        firstCommentModel.randShow += LoadDataNum;//randShow 初始值是 preMax
//        if (firstCommentModel.rand > firstCommentModel.randShow) {//还有数据
//            firstCommentModel.PreMax += LoadDataNum;
//            firstCommentModel._hasMore = YES;
//        }else{//fcm.rand = preMax + 1 + LoadDataNum 数据没了
//            firstCommentModel._hasMore = NO;
//        }
//
//        if (firstCommentModel._hasMore) {
//            if ((firstCommentModel.isFullShow && indexPath.row < firstCommentModel.childMutArr.count) ||
//                indexPath.row < firstCommentModel.PreMax) {
//                #pragma warning 点击单元格要做的事
//                NSLog(@"KKK");
//            }else{
//                firstCommentModel.isFullShow = !firstCommentModel.isFullShow;
//            }
//        }else{}
//    #warning 使用动画刷屏 在下面几个数据刷新的时候会闪屏
//    //        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
//    //                 withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView reloadData];
//    }
//    else if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:InfoTBVCell.class]){// 有内容
//        InfoTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        self.childCommentModel = cell.childCommentModel;
//        self.commentId = self.childCommentModel.commentId;
//        self.ID = self.childCommentModel.ID;
//        @weakify(self)
//        [cell action:^(id data) {
//            @strongify(self)
//            [self likeBtnClickAction:cell.LikeBtn];
//        }];
//        [NSObject showSYSActionSheetTitle:nil
//                                  message:nil
//                          isSeparateStyle:YES
//                           btnTitleArr:@[@"回复",@"复制",@"举报",@"取消"]
//                           alertBtnAction:@[@"reply",@"copyIt",@"report",@"cancel"]
//                                 targetVC:self
//                                   sender:nil
//                             alertVCBlock:^(id data) {
//            //DIY
//        }];
//    }else{}
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{// 二级评论
    MKFirstCommentModel *firstCommentModel = (MKFirstCommentModel *)self.mjModel.listMutArr[section];
    MKFirstCommentCustomCofigModel *customCofigModel = MKFirstCommentCustomCofigModel.new;
    customCofigModel.childMutArr = firstCommentModel.childMutArr;
    return customCofigModel.firstShonNum;
}
//二级评论数据 展示在cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MKFirstCommentModel *firstCommentModel = (MKFirstCommentModel *)self.mjModel.listMutArr[indexPath.section];//一级评论数据 展示在viewForHeaderInSection
    MKChildCommentModel *childCommentModel = firstCommentModel.childMutArr[indexPath.row];//二级评论数据 展示在cellForRowAtIndexPath
    
    MKFirstCommentCustomCofigModel *customCofigModel = MKFirstCommentCustomCofigModel.new;
    customCofigModel.childMutArr = firstCommentModel.childMutArr;
    
    if (customCofigModel.isFullShow) {
        InfoTBVCell *cell = [InfoTBVCell cellWithTableView:tableView];
        [cell richElementsInCellWithModel:childCommentModel];
        @weakify(self)
        [cell actionBlockInfoTBVCell:^(id data) {
            @strongify(self)
        }];return cell;
    }else{
        if (indexPath.row <= customCofigModel.firstShonNum) {
            // 二级评论展示...
            InfoTBVCell *cell = [InfoTBVCell cellWithTableView:tableView];
            [cell richElementsInCellWithModel:childCommentModel];
            @weakify(self)
            [cell actionBlockInfoTBVCell:^(id data) {
                @strongify(self)
            }];return cell;
        }else{
            // 加载更多...
            LoadMoreTBVCell *cell = [LoadMoreTBVCell cellWithTableView:tableView];
            [cell richElementsInCellWithModel:nil];
            return cell;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mjModel.listMutArr.count;//一级评论
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [JobsCommentPopUpViewForTVH viewForTableViewHeaderHeightWithModel:nil];
}
//一级评论数据 展示在viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    MKFirstCommentModel *firstCommentModel = self.mjModel.listMutArr[section];//一级评论数据 展示在viewForHeaderInSection
    JobsCommentPopUpViewForTVH *header = [[JobsCommentPopUpViewForTVH alloc] initWithReuseIdentifier:NSStringFromClass(JobsCommentPopUpViewForTVH.class) withData:firstCommentModel];
    @weakify(self)
    [header actionBlockjobsCommentPopUpViewForTVHBlock:^(id data) {
        @strongify(self)
    }];return header;
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    [self.tableView.mj_header endRefreshing];
//
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
//    [self.tableView reloadData];
    //特别说明：pagingEnabled = YES 在此会影响Cell的偏移量，原作者希望我们在这里临时关闭一下，刷新完成以后再打开
    self.tableView.pagingEnabled = NO;
    [self performSelector:@selector(delayMethods)
               withObject:nil
               afterDelay:2];
}

-(void)delayMethods{
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.pagingEnabled = YES;
//    [self.mj_footer endRefreshingWithNoMoreData];
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = HEXCOLOR(0x242A37);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = self.mjRefreshGifHeader;
        _tableView.mj_footer = self.mjRefreshBackNormalFooter;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.mj_footer.hidden = NO;
        _tableView.tableFooterView = UIView.new;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, self.popUpHeight, 0);
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                          titleStr:@"没有评论"
                                                         detailStr:@"来发布第一条吧"];
        
        if (self.mjModel.listMutArr.count) {
            [_tableView ly_hideEmptyView];
        }else{
            [_tableView ly_showEmptyView];
        }

        @weakify(self)
        _tableView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
            @strongify(self)
            sleep(3);
            [self pullToRefresh];
        }];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
        }];
    }return _tableView;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        _cancelBtn.size = CGSizeMake(50, 50);
        [_cancelBtn setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"删除")
                    forState:UIControlStateNormal];
        @weakify(self)
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"点击了删除按钮");
            [self dismissViewControllerAnimated:YES
                                     completion:Nil];
        }];
    }return _cancelBtn;
}

@end
