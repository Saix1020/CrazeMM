// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserInfo.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoID : NSManagedObjectID {}
@end

@interface _UserInfo : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserInfoID *objectID;

@property (nonatomic, strong, nullable) NSNumber* logged;

@property (atomic) BOOL loggedValue;
- (BOOL)loggedValue;
- (void)setLoggedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* name;

@end

@interface _UserInfo (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveLogged;
- (void)setPrimitiveLogged:(NSNumber*)value;

- (BOOL)primitiveLoggedValue;
- (void)setPrimitiveLoggedValue:(BOOL)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

@interface UserInfoAttributes: NSObject 
+ (NSString *)logged;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
