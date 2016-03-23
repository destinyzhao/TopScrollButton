//
//  ScrollButton.h
//  TopScrollButton
//
//  Created by Alex on 16/3/23.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnClickedBlock)(NSInteger index);

@interface ScrollButton : UIView

@property (strong, nonatomic) NSMutableArray *btnTitleArray;

@property (copy , nonatomic) BtnClickedBlock btnClickedBlock;

- (void)buttonClickedBlock:(BtnClickedBlock)btnClickedBlock;

@end
