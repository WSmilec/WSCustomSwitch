//
//  WSCustomSwitch.h
//  WSCustomSwitch
//
//  Created by WangS on 2017/4/1.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSCustomSwitch : UIControl
- (instancetype)initWithFrame:(CGRect)frame onColor:(UIColor *)onColor offColor:(UIColor *)offColor onText:(NSString *)onText offText:(NSString *)offText textColor:(UIColor *)textColor font:(UIFont *)font ballSize:(CGFloat )ballSize;
@property (nonatomic,assign) BOOL on;
@end
