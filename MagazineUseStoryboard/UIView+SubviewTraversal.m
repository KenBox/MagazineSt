//
//  UIView+SubviewTraversal.m
//  MagazineProject
//
//  Created by Ken on 13-12-7.
//  Copyright (c) 2013年 LiuLiLi. All rights reserved.
//

#import "UIView+SubviewTraversal.h"

@implementation UIView (SubviewTraversal)

-(void)printSubviews{
    NSLog(@"======printSubviews=======");
    [self printSubviewsWithIndentString:Nil];
}

-(void)printSubviewsWithIndentString:(NSString *)indentString{
    if (indentString == Nil) {
        indentString = @"";
    }
    NSString * viewDescription = NSStringFromClass(self.class);
    printf("%s+-%s\n",[indentString UTF8String],[viewDescription UTF8String]);
    if (self.subviews) {
        NSArray * siblings = self.superview.subviews;
        if ([siblings count]>1 && ([siblings indexOfObject:self]<[siblings count]-1)) {
            indentString = [indentString stringByAppendingString:@"|"];
        }else{
            indentString = [indentString stringByAppendingString:@" "];
        }
    }
    for (UIView * subview in self.subviews) {
        [subview printSubviewsWithIndentString:indentString];
    }
}


-(NSArray *)subviewsMatchingClass:(Class)aClass{
    NSMutableArray * array = [NSMutableArray array];
    [self populateSubviewsOfClass:aClass inArray:array exactMatch:YES];
    return array;
}
-(NSArray *)subviewsMatchingOrInheritingClass:(Class)aClass{
    NSMutableArray * array = [NSMutableArray array];
    [self populateSubviewsOfClass:aClass inArray:array exactMatch:NO];
    return array;
}
-(void)populateSubviewsOfClass:(Class)aClass inArray:(NSMutableArray *)array exactMatch:(BOOL)exactMatch{
    if (exactMatch) {
        if ([self isMemberOfClass:aClass]) {
            [array addObject:self];
        }else{
            if ([self isKindOfClass:aClass]) {
                [array addObject:self];
            }
        }
        for (UIView * subview in self.subviews) {
            [subview populateSubviewsOfClass:aClass inArray:array exactMatch:exactMatch];
        }
    }
}


@end
