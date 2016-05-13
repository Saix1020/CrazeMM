// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SearchHistory.h instead.

@import CoreData;

extern const struct SearchHistoryAttributes {
	__unsafe_unretained NSString *keyword;
} SearchHistoryAttributes;

@interface SearchHistoryID : NSManagedObjectID {}
@end

@interface _SearchHistory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SearchHistoryID* objectID;

@property (nonatomic, strong) NSString* keyword;

//- (BOOL)validateKeyword:(id*)value_ error:(NSError**)error_;

@end

@interface _SearchHistory (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveKeyword;
- (void)setPrimitiveKeyword:(NSString*)value;

@end
