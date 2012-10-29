//
//  NSDictionary+Expectations.h
//  WordPress
//
//  Created by Jorge Bernal on 10/29/12.
//  Copyright (c) 2012 WordPress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Expectations)

/**
 Returns a NSNumber value for the specified key. If the result is not a NSNumber and can't converted to one, it returns nil
 */
- (NSString *)stringForKey:(id)key;

/**
 Returns a NSString value for the specified key. If the result is not a NSString and can't converted to one, it returns nil
 */
- (NSNumber *)numberForKey:(id)key;

@end
