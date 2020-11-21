// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHistory.m instead.

#import "_UserHistory.h"

@implementation UserHistoryID
@end

@implementation _UserHistory

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"UserHistory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"UserHistory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"UserHistory" inManagedObjectContext:moc_];
}

- (UserHistoryID*)objectID {
	return (UserHistoryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@end

@implementation UserHistoryAttributes 
+ (NSString *)name {
	return @"name";
}
@end

