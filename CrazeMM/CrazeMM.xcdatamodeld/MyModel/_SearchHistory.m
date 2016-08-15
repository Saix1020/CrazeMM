// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SearchHistory.m instead.

#import "_SearchHistory.h"

const struct SearchHistoryAttributes SearchHistoryAttributes = {
	.keyword = @"keyword",
};

@implementation SearchHistoryID
@end

@implementation _SearchHistory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SearchHistory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SearchHistory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SearchHistory" inManagedObjectContext:moc_];
}

- (SearchHistoryID*)objectID {
	return (SearchHistoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic keyword;

@end

