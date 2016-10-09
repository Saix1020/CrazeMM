// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SearchHistory.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface SearchHistoryID : NSManagedObjectID {}
@end

@interface _SearchHistory : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SearchHistoryID *objectID;

@property (nonatomic, strong, nullable) NSString* keyword;

@end

@interface _SearchHistory (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveKeyword;
- (void)setPrimitiveKeyword:(NSString*)value;

@end

@interface SearchHistoryAttributes: NSObject 
+ (NSString *)keyword;
@end

NS_ASSUME_NONNULL_END
