// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserInfo.m instead.

#import "_UserInfo.h"

const struct UserInfoAttributes UserInfoAttributes = {
	.logged = @"logged",
	.name = @"name",
};

@implementation UserInfoID
@end

@implementation _UserInfo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"UserInfo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"UserInfo" inManagedObjectContext:moc_];
}

- (UserInfoID*)objectID {
	return (UserInfoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"loggedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"logged"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic logged;

- (BOOL)loggedValue {
	NSNumber *result = [self logged];
	return [result boolValue];
}

- (void)setLoggedValue:(BOOL)value_ {
	[self setLogged:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveLoggedValue {
	NSNumber *result = [self primitiveLogged];
	return [result boolValue];
}

- (void)setPrimitiveLoggedValue:(BOOL)value_ {
	[self setPrimitiveLogged:[NSNumber numberWithBool:value_]];
}

@dynamic name;

@end

