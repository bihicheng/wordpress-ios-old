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

@end
