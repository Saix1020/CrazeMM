// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHistory.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UserHistoryID : NSManagedObjectID {}
@end

@interface _UserHistory : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserHistoryID *objectID;

@property (nonatomic, strong, nullable) NSString* name;

@end

@interface _UserHistory (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

@interface UserHistoryAttributes: NSObject 
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
