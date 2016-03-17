//
//  MessageView.m
//  SendMessage
//
//  Created by Richard Liang on 16/3/16.
//  Copyright © 2016年 lwj. All rights reserved.
//

#import "MessageView.h"
#import "JKKeyboardObserver.h"
#import "AppDelegate+JKKeyboardObserver.h"

#define DefaultRect CGRectMake(0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width,50)

@interface MessageView()

@property (strong, nonatomic) UITextView *innerTextView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGRect cellRect;

@end

@implementation MessageView

- (void)dealloc{
    [[AppDelegate appDelegate]stopObserveKeyboard];
}

+ (instancetype)shareView {
    static MessageView *shareView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareView = [[MessageView alloc]initWithFrame:DefaultRect];
    });
    return shareView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        _innerTextView = [[UITextView alloc]initWithFrame:frame];
        _innerTextView.backgroundColor = [UIColor blueColor];
        [self addSubview:_innerTextView];
        [self setupDefaults];
    }
    return self;
}

+ (void)showInScrollView:(UIScrollView *)scrollView belowCellRect:(CGRect)cellRect{
    MessageView *messageView = [MessageView shareView];
    messageView.scrollView = scrollView;
    messageView.cellRect = cellRect;
    [messageView show];
}

- (void)setupDefaults{
    __weak __typeof(&*self)weakSelf = self;
    [[AppDelegate appDelegate]startObserveKeyboard];
    [[AppDelegate appDelegate]keyboardWillShow:^(CGFloat keyboardHeight, CGFloat duration) {
        weakSelf.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - keyboardHeight - CGRectGetHeight(weakSelf.frame), CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.frame));
        CGFloat offsetY = [weakSelf caculateOffsetYWithKeyboardHeight:keyboardHeight];
        [weakSelf.scrollView setContentOffset:CGPointMake(0, weakSelf.scrollView.contentOffset.y - offsetY) animated:YES];
    } keyboardWillHide:^(CGFloat keyboardHeight, CGFloat duration) {
        weakSelf.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.frame));
        [weakSelf.scrollView setContentOffset:weakSelf.scrollView.contentOffset animated:YES];
        [weakSelf removeFromSuperview];
    }];
}

- (CGFloat)caculateOffsetYWithKeyboardHeight:(CGFloat)keyboardHeight{
    CGFloat cellTopY = CGRectGetMinY(self.cellRect);
    CGFloat cellHeight = CGRectGetHeight(self.cellRect);
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    return screenHeight - keyboardHeight - CGRectGetHeight(self.frame) - cellTopY - cellHeight;
}

- (void)show{
    if (self.innerTextView.isFirstResponder) {
        [self.innerTextView resignFirstResponder];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self.innerTextView becomeFirstResponder];
    }
}

@end
