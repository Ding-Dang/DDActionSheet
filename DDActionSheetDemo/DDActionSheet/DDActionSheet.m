//
//  DDActionSheet.m
//  DDActionSheetDemo
//
//  Created by DingDang on 15/6/9.
//  Copyright (c) 2015年 DingDang. All rights reserved.
//

#define COLOR(rgb, a)           ([UIColor colorWithRed:(rgb & 0xFF0000 >> 16)/255.0 green:(rgb & 0xFF00 >> 8)/255.0 blue:(rgb &0x0000FF)/255.0 alpha:(a)])
#define BLUR_COLOR              COLOR(0, 0.4)
#define WINDOW_COLOR            COLOR(0xf44feb, 1)
#define ANIMATE_DURATION        0.25f

#define VIEW_LEFT_MARGIN        15
#define VIEW_TOP_MARGIN         20
#define VIEW_BOTTOM_MARGIN      15

#define BUTTON_SPACE            10
#define BUTTON_HEIGHT           (28 + 16)
#define BUTTON_CORNER_RADIUS    3
#define BUTTON_BORDER_WIDTH     1

#import "DDActionSheet.h"

@interface DDActionSheet() {
    NSUInteger buttonNum;
}


@property (nonatomic, assign) CGFloat containerHeight;
@property (nonatomic,assign) id<DDActionSheetDelegate>delegate;

@property (nonatomic, strong) UIView *containerView;

@end

@implementation DDActionSheet

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<DDActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    self = [super init];
    if (self) {
        buttonNum = otherButtonTitlesArray.count + 1;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = BLUR_COLOR;
        _delegate = delegate;
        [self createButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitlesArray];
    }
    return self;
}

- (void)createButtonsWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), 0)];
    _containerView.backgroundColor = WINDOW_COLOR;
    [self addSubview:_containerView];
    _containerHeight = VIEW_TOP_MARGIN;

    for (NSUInteger i = 0; i < otherButtonTitlesArray.count; ++i) {
        [self createButtonWithTitle:otherButtonTitlesArray[i] andIndex:i];
    }
    [self createButtonWithTitle:cancelButtonTitle andIndex:otherButtonTitlesArray.count];
    _containerHeight += (VIEW_BOTTOM_MARGIN - BUTTON_SPACE);

    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        CGRect frame = self.containerView.frame;
        self.containerView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - _containerHeight, frame.size.width, _containerHeight);
    } completion:^(BOOL finished) {
    }];
}

- (void)createButtonWithTitle:(NSString *)title andIndex:(NSInteger)index
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_LEFT_MARGIN, VIEW_TOP_MARGIN + (BUTTON_HEIGHT + BUTTON_SPACE) * index, CGRectGetWidth([UIScreen mainScreen].bounds) - 2 *VIEW_LEFT_MARGIN, BUTTON_HEIGHT)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.tag = index;
    [button addTarget:self action:@selector(clickOnButton:) forControlEvents:UIControlEventTouchUpInside];

    button.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    button.clipsToBounds = YES;
    button.layer.borderWidth = BUTTON_BORDER_WIDTH;

    [self.containerView addSubview:button];
    self.containerHeight += (BUTTON_HEIGHT + BUTTON_SPACE);
}

- (void)clickOnButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:button.tag];
    }
    if ([self.delegate respondsToSelector:@selector(actionSheetCancel:)] && button.tag == buttonNum-1) {
        [self.delegate actionSheetCancel:self];
    }
    [self dismiss];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.containerView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
