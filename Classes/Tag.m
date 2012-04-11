//
//  Tag.m
//  WordPress
//
//  Created by Jorge Bernal on 4/11/12.
//  Copyright (c) 2012 WordPress. All rights reserved.
//

#import "Tag.h"

@interface Tag(PrivateMethods)
+ (Tag *)newTagForBlog:(Blog *)blog;
@end


@implementation Tag
@dynamic tagID, name, count;
@dynamic blog, posts;

+ (Tag *)newTagForBlog:(Blog *)blog {
    Tag *tag = [[Tag alloc] initWithEntity:[NSEntityDescription entityForName:@"Tag"
                                                       inManagedObjectContext:[blog managedObjectContext]]
            insertIntoManagedObjectContext:[blog managedObjectContext]];
    
    tag.blog = blog;
    
    return tag;
}

+ (BOOL)existsName:(NSString *)name forBlog:(Blog *)blog {
    return [self findWithBlog:blog andName:name] != nil;
}

+ (Tag *)findWithBlog:(Blog *)blog andName:(NSString *)name {
    Tag *tag = nil;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@", name];
    NSSet *items = [blog.tags filteredSetUsingPredicate:predicate];
    if ((items != nil) && (items.count > 0)) {
        tag = [[items allObjects] objectAtIndex:0];
    }
    return tag;
}

+ (Tag *)findWithBlog:(Blog *)blog andTagID:(NSNumber *)tagID {
    NSSet *results = [blog.tags filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"tagID == %@", tagID]];
    
    if (results && (results.count > 0)) {
        return [[results allObjects] objectAtIndex:0];
    }
    return nil;
}


+ (Tag *)createOrReplaceFromDictionary:(NSDictionary *)tagInfo forBlog:(Blog *)blog {
    if ([tagInfo objectForKey:@"term_id"] == nil) {
        return nil;
    }
    if ([tagInfo objectForKey:@"name"] == nil) {
        return nil;
    }
    
    Tag *tag = [self findWithBlog:blog andTagID:[[tagInfo objectForKey:@"term_id"] numericValue]];
    if (tag == nil) {
        tag = [[Tag newTagForBlog:blog] autorelease];
    }
    
    tag.tagID = [[tagInfo objectForKey:@"term_id"] numericValue];
    tag.name = [tagInfo objectForKey:@"name"];
    tag.count = [tagInfo objectForKey:@"count"];
    
    return tag;
}

+ (Tag *)createTag:(NSString *)name forBlog:(Blog *)blog success:(void (^)(Tag *))success failure:(void (^)(NSError *))failure {
    Tag *tag = [Tag newTagForBlog:blog];
    tag.name = name;
    tag.count = [NSNumber numberWithInt:1];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                tag.name, @"name",
                                @"post_tag", @"taxonomy",
                                nil];
    [blog.api callMethod:@"wp.newTerm"
              parameters:[blog getXMLRPCArgsWithExtra:parameters]
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     int newID = [responseObject intValue];
                     if (newID > 0) {
                         tag.tagID = [NSNumber numberWithInt:newID];
                         [blog dataSave];
                     }
                     if (success) {
                         success(tag);
                     }
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     WPLog(@"Error while creating tag: %@", [error localizedDescription]);
                     [[blog managedObjectContext] deleteObject:tag];
                     [blog dataSave];
                     if (failure) {
                         failure(error);
                     }
                 }];

    return tag;
}

@end
