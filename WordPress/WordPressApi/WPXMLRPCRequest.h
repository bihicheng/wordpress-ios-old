//
//  AFXMLRPCRequest.h
//  WordPress
//
//  Created by Jorge Bernal on 2/20/13.
//  Copyright (c) 2013 WordPress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPXMLRPCRequest : NSObject
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSArray *parameters;
@end