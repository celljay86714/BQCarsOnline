//
//  UIPlaceHolderTextView.m
//  VKProprietorAssistant
//
//  Created by admin on 16/1/28.
//  Copyright © 2016年 Vanke. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@interface UIPlaceHolderTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation UIPlaceHolderTextView

CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [_placeHolderLabel release]; _placeHolderLabel = nil;
    [_placeholderColor release]; _placeholderColor = nil;
    [_placeholder release]; _placeholder = nil;
    [super dealloc];
#endif
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];

}

- (id)initWithFrame:(CGRect)frame {
    if( (self = [super initWithFrame:frame]) ) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    if (!self.placeholder) {
        _placeholder = @"";
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];

}

- (void)textChanged:(NSNotification *)notification {
    

    if([[self placeholder] length] == 0) {
        return;
    }
    
    if([[self text] length] != 0) {
        [[self viewWithTag:999] setAlpha:0];
//        DDLogError(@"notification%@", notification);
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.lineSpacing = 5;
//        
//        NSDictionary *attributes = @{
//                                     NSFontAttributeName:self.font,
//                                     NSParagraphStyleAttributeName:paragraphStyle
//                                     };
//        self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0) {
            [[self viewWithTag:999] setAlpha:1];
        }
    }];

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView { //其实你可以加在这个代理方法中。当你将要编辑的时候。先执行这个代理方法的时候就可以改变间距了。这样之后输入的内容也就有了行间距。
    

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];

    
    return YES;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect {
    //    [super drawRect:rect];、
    if( [[self placeholder] length] > 0 ) {
        UIEdgeInsets insets = self.textContainerInset;
        if (_placeHolderLabel == nil ) {
            
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(insets.left+5, insets.top, self.bounds.size.width - (insets.left +insets.right+10), 1.0)];
            
            //            _placeHolderLabel = [UILabel new];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            _placeHolderLabel.numberOfLines = 0;
            [self addSubview:_placeHolderLabel];
            [self sendSubviewToBack:_placeHolderLabel];
        }
//        _placeHolderLabel.text = self.placeholder;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5.0];// 调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.placeholder length])];
        _placeHolderLabel.attributedText = attributedString;
        [_placeHolderLabel sizeToFit];
        [_placeHolderLabel setFrame:CGRectMake(insets.left+5, insets.top, self.bounds.size.width - (insets.left +insets.right+10), CGRectGetHeight(_placeHolderLabel.frame))];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 ) {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        [self setNeedsDisplay];
    }
    
}

@end
