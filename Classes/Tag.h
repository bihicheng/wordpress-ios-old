//
//  Tag.h
//  WordPress
//
//  Created by Jorge Bernal on 4/11/12.
//  Copyright (c) 2012 WordPress. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Blog.h"

@interface Tag : NSManagedObject
@property (nonatomic, retain) NSNumber *tagID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *count;

@property (nonatomic, retain) Blog *blog;
@property (nonatomic, retain) NSMutableSet *posts;

+ (BOOL)existsName:(NSString *)name forBlog:(Blog *)blog;
+ (Tag *)findWithBlog:(Blog *)blog andName:(NSString *)name;
+ (Tag *)findWithBlog:(Blog *)blog andTagID:(NSNumber *)tagID;
+ (Tag *)createOrReplaceFromDictionary:(NSDictionary *)tagInfo forBlog:(Blog *)blog;
+ (Tag *)createTag:(NSString *)name forBlog:(Blog *)blog success:(void (^)(Tag *tag))success failure:(void (^)(NSError *error))failure;

@end
