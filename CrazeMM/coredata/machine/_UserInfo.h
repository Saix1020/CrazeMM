// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserInfo.h instead.

#import <CoreData/CoreData.h>

extern const struct UserInfoAttributes {
	__unsafe_unretained NSString *logged;
	__unsafe_unretained NSString *name;
} UserInfoAttributes;

@interface UserInfoID : NSManagedObjectID {}
@end

@interface _UserInfo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserInfoID* objectID;

@property (nonatomic, strong) NSNumber* logged;

@property (atomic) BOOL loggedValue;
- (BOOL)loggedValue;
- (void)setLoggedValue:(BOOL)value_;

//- (BOOL)validateLogged:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _UserInfo (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveLogged;
- (void)setPrimitiveLogged:(NSNumber*)value;

- (BOOL)primitiveLoggedValue;
- (void)setPrimitiveLoggedValue:(BOOL)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end
