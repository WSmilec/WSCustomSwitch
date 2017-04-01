//
//  WSCustomSwitch.m
//  WSCustomSwitch
//
//  Created by WangS on 2017/4/1.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "WSCustomSwitch.h"

@interface WSCustomSwitch ()
@property (nonatomic,strong) UIColor *onColor;
@property (nonatomic,strong) UIColor *offColor;
@property (nonatomic,copy) NSString *onText;
@property (nonatomic,copy) NSString *offText;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) CGFloat ballSize;
@property (nonatomic,weak) UIView *containerView;
@property (nonatomic,weak) UIView *backgroupView;
@property (nonatomic,weak) UIView *ballView;
@property (nonatomic,weak) UIView *onView;
@property (nonatomic,weak) UIView *offView;
@property (nonatomic,weak) UILabel *onLab;
@property (nonatomic,weak) UILabel *offLab;
@property (nonatomic,assign) CGFloat offPosition;
@property (nonatomic,assign) CGFloat initialOffset;
@end
@implementation WSCustomSwitch
- (instancetype)initWithFrame:(CGRect)frame onColor:(UIColor *)onColor offColor:(UIColor *)offColor onText:(NSString *)onText offText:(NSString *)offText textColor:(UIColor *)textColor font:(UIFont *)font ballSize:(CGFloat )ballSize{
    if (self = [super initWithFrame:frame]) {
        self.onColor = onColor;
        self.offColor = offColor;
        self.onText = onText;
        self.offText = offText;
        self.textColor = textColor;
        self.font = font;
        self.ballSize = ballSize;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    UIView *containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    self.containerView = containerView;
    
    UIView *backgroupView = [[UIView alloc] init];
    [containerView addSubview:backgroupView];
    self.backgroupView = backgroupView;
    
    UIView *ballView = [[UIView alloc] init];
    ballView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:ballView];
    self.ballView = ballView;
    
    UIView *onView = [[UIView alloc] init];
    onView.backgroundColor = self.onColor;
    [backgroupView addSubview:onView];
    self.onView = onView;
    UILabel *onLab = [[UILabel alloc] init];
    onLab.textAlignment = NSTextAlignmentCenter;
    onLab.font = self.font;
    onLab.textColor = self.textColor;
    onLab.text = self.onText;
    [onView addSubview:onLab];
    self.onLab = onLab;
    
    
    UIView *offView = [[UIView alloc] init];
    offView.backgroundColor = self.offColor;
    [backgroupView addSubview:offView];
    self.offView = offView;
    UILabel *offLab = [[UILabel alloc] init];
    offLab.textAlignment = NSTextAlignmentCenter;
    offLab.font = self.font;
    offLab.textColor = self.textColor;
    offLab.text = self.offText;
    [offView addSubview:offLab];
    self.offLab = offLab;
    
    [self.backgroupView bringSubviewToFront:self.onView];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidChange:)];
    [self addGestureRecognizer:panGestureRecognizer];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerDidChange:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.containerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.containerView.layer.cornerRadius = self.frame.size.height / 2.0;
    self.containerView.layer.masksToBounds = YES;
    
    self.backgroupView.frame = CGRectMake(0, 0, self.frame.size.width * 2.0 - self.ballSize,self.frame.size.height);
    
    self.ballView.frame = CGRectMake(self.frame.size.width-self.ballSize,(self.frame.size.height - self.ballSize)/2.0 , self.ballSize, self.ballSize);
    self.ballView.layer.cornerRadius = self.ballSize / 2.0;
    self.ballView.layer.masksToBounds = YES;
    
    self.onView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.onView.layer.cornerRadius = self.frame.size.height / 2.0;
    self.onView.layer.masksToBounds = YES;
    
    self.onLab.frame = CGRectMake(0, 0, self.frame.size.width - self.ballSize, self.frame.size.height);
    
    self.offView.frame = CGRectMake(self.frame.size.width-self.ballSize, 0, self.frame.size.width, self.frame.size.height);
    self.offView.layer.cornerRadius = self.frame.size.height / 2.0;
    self.offView.layer.masksToBounds = YES;
    
    self.offLab.frame = CGRectMake(self.ballSize, 0, self.frame.size.width - self.ballSize, self.frame.size.height);
    
    
}

- (void)setOn:(BOOL)on{
    _on = on;
    
    CGRect frame = self.backgroupView.frame;
    if (on) {
        frame.origin.x = 0;
        [self.backgroupView bringSubviewToFront:self.onView];
    }else{
        frame.origin.x = self.offPosition;
        [self.backgroupView bringSubviewToFront:self.offView];
    }
    self.backgroupView.frame = frame;
    CGRect knobFrame = self.ballView.frame;
    knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width ;
    self.ballView.frame = knobFrame;
}

- (CGFloat)offPosition{
    return -self.frame.size.width + self.ballView.frame.size.width;
}
- (void)panGestureRecognizerDidChange:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.backgroupView];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _initialOffset = self.backgroupView.frame.origin.x;
    }
    
    float x = translation.x;
    x = translation.x + _initialOffset;
    
    CGRect frame = self.backgroupView.frame;
    frame.origin.x = x;
    if (frame.origin.x > 0) {
        frame.origin.x = 0;
    }
    if (frame.origin.x < self.offPosition){
        frame.origin.x = self.offPosition;
    }
    self.backgroupView.frame = frame;
    
    CGRect knobFrame = self.ballView.frame;
    knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width;
    self.ballView.frame = knobFrame;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (self.on) {
            [self.backgroupView bringSubviewToFront:self.onView];
        }else{
            [self.backgroupView bringSubviewToFront:self.offView];
        }
        if (frame.origin.x > -self.frame.size.width / 2) {
            frame.origin.x = 0;
        } else {
            frame.origin.x = self.offPosition;
        }
        
        [UIView animateWithDuration:0.1 animations:^{
            self.backgroupView.frame = frame;
            
            CGRect knobFrame = self.ballView.frame;
            knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width;
            self.ballView.frame = knobFrame;
        }];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}
- (void)tapGestureRecognizerDidChange:(UITapGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGRect frame = self.backgroupView.frame;
        if (frame.origin.x == 0) {
            frame.origin.x = self.offPosition;
            [self.backgroupView bringSubviewToFront:self.offView];
        } else {
            frame.origin.x = 0;
            [self.backgroupView bringSubviewToFront:self.onView];
            
        }
        [UIView animateWithDuration:0.15 animations:^{
            self.backgroupView.frame = frame;
            CGRect knobFrame = self.ballView.frame;
            knobFrame.origin.x = frame.origin.x + self.frame.size.width - knobFrame.size.width ;
            self.ballView.frame = knobFrame;
        }];
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}


@end
