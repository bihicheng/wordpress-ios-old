//
//  NSDictionary+Expectations.m
//  WordPress
//
//  Created by Jorge Bernal on 10/29/12.
//  Copyright (c) 2012 WordPress. All rights reserved.
//

#import "NSDictionary+Expectations.h"

@implementation NSDictionary (Expectations)

- (NSString *)stringForKey:(id)key {
    NSString *string = [self objectForKey:key];

    if (![string isKindOfClass:[NSString class]] && [string respondsToSelector:@selector(stringValue)])
        string = [string performSelector:@selector(stringValue)];

    if (![string isKindOfClass:[NSString class]])
        string = nil;

    return string;
}

- (NSNumber *)numberForKey:(id)key {
    NSNumber *number = [self objectForKey:key];

    if (![number isKindOfClass:[NSNumber class]] && [number respondsToSelector:@selector(numericValue)])
        number = [number performSelector:@selector(numericValue)];

    if (![number isKindOfClass:[NSNumber class]])
        number = nil;

    return number;
}

@end
