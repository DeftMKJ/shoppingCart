//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"

@implementation SKTagButton

+ (instancetype)buttonWithTag: (SKTag *)tag {
	SKTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
	
	if (tag.attributedText) {
		[btn setAttributedTitle: tag.attributedText forState: UIControlStateNormal];
	} else {
		[btn setTitle: tag.text forState:UIControlStateNormal];
		[btn setTitleColor: tag.textColor forState: UIControlStateNormal];
		btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize: tag.fontSize];
	}
	
	btn.backgroundColor = tag.bgColor;
	btn.contentEdgeInsets = tag.padding;
	btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
    if (tag.bgImg) {
        [btn setBackgroundImage: tag.bgImg forState: UIControlStateNormal];
    }
    
    if (tag.borderColor) {
        btn.layer.borderColor = tag.borderColor.CGColor;
    }
    
    if (tag.borderWidth) {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    btn.userInteractionEnabled = tag.enable;
    if (tag.enable) {
        UIColor *highlightedBgColor = tag.highlightedBgColor ?: [self darkerColor:btn.backgroundColor];
        [btn setBackgroundImage:[self imageWithColor:highlightedBgColor] forState:UIControlStateHighlighted];
    }
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
//    
    CGRect rec = [tag.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:12]} context:nil];
    
    NSLog(@"每个文字的Rec:%@",NSStringFromCGRect(rec));
    UIImage *image = [self imageWithColor:[UIColor redColor] forSize:CGSizeMake(rec.size.width+10, 5)];
    [btn setImage:image forState:UIControlStateNormal];
//
    
    btn.titleLabel.backgroundColor = btn.backgroundColor;
    btn.imageView.backgroundColor = btn.backgroundColor;
    
    CGSize titleSize = btn.titleLabel.bounds.size;
    CGSize imageSize = btn.imageView.image.size;
    CGFloat interval = 20;
    
//    [btn setImageEdgeInsets:UIEdgeInsetsMake((titleSize.height + interval), 0.0, 0.0, 0)];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, - imageSize.width, (imageSize.height + interval), 0.0)];
    
    // 图片往下和右移动
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, -(titleSize.height + interval),0)];
    // 文字往上和左移动
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(-(imageSize.height + interval), - imageSize.width, 0.0, 0.0)];
    
    
    return btn;
}



+ (UIImage*)imageWithColor:(UIColor *)color forSize:(CGSize)size
{
    if (size.width <= 0 || size.height<= 0 )
    {
        return nil;
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIColor *)darkerColor:(UIColor *)color {
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.85
                               alpha:a];
    return color;
}

@end
