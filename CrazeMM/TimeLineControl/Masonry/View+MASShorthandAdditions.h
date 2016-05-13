//
//  UIView+MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+MASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface MAS_VIEW (MASShorthandAdditions)

@property (nonatomic, strong, readonly) MASViewAttribute *masx_left;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_top;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_right;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_leading;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_width;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_height;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_centerY;
@property (nonatomic, strong, readonly) MASViewAttribute *masx_baseline;
@property (nonatomic, strong, readonly) MASViewAttribute *(^attribute)(NSLayoutAttribute attr);

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

#define MAS_ATTR_FORWARD(attr)  \
- (MASViewAttribute *)masx_##attr {    \
    return [self mas_##attr];   \
}

@implementation MAS_VIEW (MASShorthandAdditions)

MAS_ATTR_FORWARD(top);
MAS_ATTR_FORWARD(left);
MAS_ATTR_FORWARD(bottom);
MAS_ATTR_FORWARD(right);
MAS_ATTR_FORWARD(leading);
MAS_ATTR_FORWARD(trailing);
MAS_ATTR_FORWARD(width);
MAS_ATTR_FORWARD(height);
MAS_ATTR_FORWARD(centerX);
MAS_ATTR_FORWARD(centerY);
MAS_ATTR_FORWARD(baseline);

- (MASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self mas_attribute];
}

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif
