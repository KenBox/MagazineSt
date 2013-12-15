//
//  UIView+SubviewTraversal.h
//  MagazineProject
//
//  Created by Ken on 13-12-7.
//  Copyright (c) 2013年 LiuLiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SubviewTraversal)


-(void)printSubviews;
-(void)printSubviewsWithIndentString:(NSString *)indentString;
-(NSArray *)subviewsMatchingClass:(Class)aClass;
-(NSArray *)subviewsMatchingOrInheritingClass:(Class)aClass;
-(void)populateSubviewsOfClass:(Class)aClass inArray:(NSMutableArray *)array exactMatch:(BOOL)exactMatch;
@end
