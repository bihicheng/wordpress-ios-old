//
//  Post.h
//  WordPress
//
//  Created by Chris Boyd on 8/9/10.
//

#import <CoreData/CoreData.h>
#import "WordPressAppDelegate.h"
#import "Category.h"
#import "AbstractPost.h"

@interface Post :  AbstractPost  
{
}

#pragma mark -
#pragma mark Properties
#pragma mark     Attributes
@property (nonatomic, retain) NSString * geolocation;
@property (nonatomic, retain) NSString * tags;

#pragma mark     Relationships
@property (nonatomic, retain) NSMutableSet * categories;
@property (nonatomic, retain) NSMutableSet * comments;

#pragma mark -
#pragma mark Methods
#pragma mark     Helpers
// Returns categories as a comma-separated list
- (NSString *)categoriesText;
- (void)setCategoriesFromNames:(NSArray *)categoryNames;
- (void)findComments;

#pragma mark     Data Management
// Autosave for local drafts
- (void)autosave;
// Upload a new post to the server
- (void)upload;

#pragma mark Class Methods
// Creates an empty local post associated with blog
+ (Post *)newDraftForBlog:(Blog *)blog;
+ (Post *)findWithBlog:(Blog *)blog andPostID:(NSNumber *)postID;
// Takes the NSDictionary from a XMLRPC call and creates or updates a post
+ (Post *)createOrReplaceFromDictionary:(NSDictionary *)postInfo forBlog:(Blog *)blog;

@end