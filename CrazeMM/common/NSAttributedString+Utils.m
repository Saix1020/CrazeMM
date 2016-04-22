//
//  NSAttributedString+Utils.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NSAttributedString+Utils.h"

@implementation NSAttributedString (Utils)


+(NSAttributedString*)composedAttributedString:(NSArray*)stringWithAttrs
{
    NSMutableAttributedString* composedAttributedString = [[NSMutableAttributedString alloc] init];
    
    for (NSDictionary* item in stringWithAttrs) {
        
        NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:item[@"string"] attributes:item[@"attributes"]];
        [composedAttributedString appendAttributedString:attrString];
    }
    
    return composedAttributedString;
}


@end
