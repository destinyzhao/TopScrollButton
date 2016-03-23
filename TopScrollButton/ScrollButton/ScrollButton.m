//
//  ScrollButton.m
//  TopScrollButton
//
//  Created by Alex on 16/3/23.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ScrollButton.h"

#define MENU_BUTTON_HEIGHT 36
#define MENU_BUTTON_WIDTH  60

#define MIN_MENU_FONT  13.f
#define MAX_MENU_FONT  18.f

@interface ScrollButton ()<UIScrollViewDelegate>
/**
 *  ScrollView
 */
@property (strong, nonatomic) UIScrollView *topScrollView;
/**
 *  上一次选中Button
 */
@property (strong, nonatomic) UIButton *lastSelectButton;
/**
 *  当前选中Button 下的线
 */
@property (strong, nonatomic) UIImageView *shadowImageView;

@end

@implementation ScrollButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSetting];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initSetting
{
    // ScrollView
    _topScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _topScrollView.delegate = self;
    _topScrollView.userInteractionEnabled = YES;
    [_topScrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:_topScrollView];
    
    // 线
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:[UIImage imageNamed:@"shadowImage"]];
    [_topScrollView addSubview:_shadowImageView];
}

/**
 *  btnTitleArray Setter
 *
 *  @param btnTitleArray btnTitleArray
 */
- (void)setBtnTitleArray:(NSMutableArray *)btnTitleArray
{
    _btnTitleArray = btnTitleArray;
    
    for (NSInteger i = 0; i < [_btnTitleArray count]; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, 0, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT)];
        [btn setTitle:[_btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MAX_MENU_FONT];
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.tag = i;
        if (i == 0) {
            btn.selected = YES;
            _lastSelectButton = btn;
            _lastSelectButton.selected = NO;
            _shadowImageView.frame = CGRectMake(0, 0, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    
        }
        [_topScrollView addSubview:btn];
    }
    
    [_topScrollView setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * [_btnTitleArray count], MENU_BUTTON_HEIGHT)];
}

/**
 *  按钮点击事件
 *
 *  @param sender
 */
- (void)actionbtn:(UIButton *)sender
{
    if (!sender.selected) {
        
        // Block 回调
        if (_btnClickedBlock) {
            _btnClickedBlock(sender.tag);
        }
        
        //之前的按钮取消选中
        _lastSelectButton.selected = NO;
        // 当前按钮选中
        sender.selected = YES;
        // 当前按钮=最后选中按钮
        _lastSelectButton = sender;
        
        // 线移动动画
        [UIView animateWithDuration:0.25 animations:^{
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, MENU_BUTTON_HEIGHT)];
        } completion:^(BOOL finished) {}];
        
        // 计算滚动X距离
        float scrollX = _topScrollView.frame.size.width * sender.tag  * (MENU_BUTTON_WIDTH / self.frame.size.width) - MENU_BUTTON_WIDTH;
        // 滚动
        [_topScrollView scrollRectToVisible:CGRectMake(scrollX, 0, _topScrollView.frame.size.width, _topScrollView.frame.size.height) animated:YES];
    }
}

/**
 *  设置Block
 *
 *  @param btnClickedBlock
 */
- (void)buttonClickedBlock:(BtnClickedBlock)btnClickedBlock
{
    _btnClickedBlock= btnClickedBlock;

     [self actionbtn:_lastSelectButton];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
