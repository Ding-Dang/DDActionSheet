//
//  DDActionSheet.h
//  DDActionSheetDemo
//
//  Created by DingDang on 15/6/9.
//  Copyright (c) 2015年 DingDang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDActionSheet;
@protocol DDActionSheetDelegate <NSObject>

@required
- (void)actionSheet:(DDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@optional
- (void)actionSheetCancel:(DDActionSheet *)actionSheet;

@end

@interface DDActionSheet : UIView

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<DDActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;

- (void)show;

@end
