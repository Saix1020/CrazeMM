#import "_SearchHistory.h"

@interface SearchHistory : _SearchHistory {}
// Custom logic goes here.

+(void)createIfNotExist:(NSString*)keyword andManagedObjectContext:(NSManagedObjectContext*)context;

+(NSArray*)findAll:(NSManagedObjectContext*)context;

+(NSArray*)findWithPredicate:(NSPredicate*)predicate andManagedObjectContext:(NSManagedObjectContext*)context;

+(void)removeAll:(NSManagedObjectContext*)context;

@end
