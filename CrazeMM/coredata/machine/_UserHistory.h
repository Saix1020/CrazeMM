// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserHistory.h instead.

#import <CoreData/CoreData.h>

extern const struct UserHistoryAttributes {
	__unsafe_unretained NSString *name;
} UserHistoryAttributes;

@interface UserHistoryID : NSManagedObjectID {}
@end

@interface _UserHistory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserHistoryID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _UserHistory (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end
