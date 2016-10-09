// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Banner.m instead.

#import "_Banner.h"

@implementation BannerID
@end

@implementation _Banner

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Banner" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Banner";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Banner" inManagedObjectContext:moc_];
}

- (BannerID*)objectID {
	return (BannerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"disabledValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"disabled"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"dtoIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dtoId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"locationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"location"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"orderNumValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"orderNum"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic bgColor;

@dynamic createTime;

@dynamic data;

@dynamic desc;

@dynamic disabled;

- (BOOL)disabledValue {
	NSNumber *result = [self disabled];
	return [result boolValue];
}

- (void)setDisabledValue:(BOOL)value_ {
	[self setDisabled:@(value_)];
}

- (BOOL)primitiveDisabledValue {
	NSNumber *result = [self primitiveDisabled];
	return [result boolValue];
}

- (void)setPrimitiveDisabledValue:(BOOL)value_ {
	[self setPrimitiveDisabled:@(value_)];
}

@dynamic dtoId;

- (int32_t)dtoIdValue {
	NSNumber *result = [self dtoId];
	return [result intValue];
}

- (void)setDtoIdValue:(int32_t)value_ {
	[self setDtoId:@(value_)];
}

- (int32_t)primitiveDtoIdValue {
	NSNumber *result = [self primitiveDtoId];
	return [result intValue];
}

- (void)setPrimitiveDtoIdValue:(int32_t)value_ {
	[self setPrimitiveDtoId:@(value_)];
}

@dynamic image;

@dynamic location;

- (int16_t)locationValue {
	NSNumber *result = [self location];
	return [result shortValue];
}

- (void)setLocationValue:(int16_t)value_ {
	[self setLocation:@(value_)];
}

- (int16_t)primitiveLocationValue {
	NSNumber *result = [self primitiveLocation];
	return [result shortValue];
}

- (void)setPrimitiveLocationValue:(int16_t)value_ {
	[self setPrimitiveLocation:@(value_)];
}

@dynamic orderNum;

- (int16_t)orderNumValue {
	NSNumber *result = [self orderNum];
	return [result shortValue];
}

- (void)setOrderNumValue:(int16_t)value_ {
	[self setOrderNum:@(value_)];
}

- (int16_t)primitiveOrderNumValue {
	NSNumber *result = [self primitiveOrderNum];
	return [result shortValue];
}

- (void)setPrimitiveOrderNumValue:(int16_t)value_ {
	[self setPrimitiveOrderNum:@(value_)];
}

@dynamic title;

@dynamic url;

@end

@implementation BannerAttributes 
+ (NSString *)bgColor {
	return @"bgColor";
}
+ (NSString *)createTime {
	return @"createTime";
}
+ (NSString *)data {
	return @"data";
}
+ (NSString *)desc {
	return @"desc";
}
+ (NSString *)disabled {
	return @"disabled";
}
+ (NSString *)dtoId {
	return @"dtoId";
}
+ (NSString *)image {
	return @"image";
}
+ (NSString *)location {
	return @"location";
}
+ (NSString *)orderNum {
	return @"orderNum";
}
+ (NSString *)title {
	return @"title";
}
+ (NSString *)url {
	return @"url";
}
@end

