// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Banner.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BannerID : NSManagedObjectID {}
@end

@interface _Banner : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BannerID *objectID;

@property (nonatomic, strong, nullable) NSString* bgColor;

@property (nonatomic, strong, nullable) NSString* createTime;

@property (nonatomic, strong, nullable) NSData* data;

@property (nonatomic, strong, nullable) NSString* desc;

@property (nonatomic, strong, nullable) NSNumber* disabled;

@property (atomic) BOOL disabledValue;
- (BOOL)disabledValue;
- (void)setDisabledValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* dtoId;

@property (atomic) int32_t dtoIdValue;
- (int32_t)dtoIdValue;
- (void)setDtoIdValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* image;

@property (nonatomic, strong, nullable) NSNumber* location;

@property (atomic) int16_t locationValue;
- (int16_t)locationValue;
- (void)setLocationValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSNumber* orderNum;

@property (atomic) int16_t orderNumValue;
- (int16_t)orderNumValue;
- (void)setOrderNumValue:(int16_t)value_;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong, nullable) NSString* url;

@end

@interface _Banner (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveBgColor;
- (void)setPrimitiveBgColor:(NSString*)value;

- (NSString*)primitiveCreateTime;
- (void)setPrimitiveCreateTime:(NSString*)value;

- (NSData*)primitiveData;
- (void)setPrimitiveData:(NSData*)value;

- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;

- (NSNumber*)primitiveDisabled;
- (void)setPrimitiveDisabled:(NSNumber*)value;

- (BOOL)primitiveDisabledValue;
- (void)setPrimitiveDisabledValue:(BOOL)value_;

- (NSNumber*)primitiveDtoId;
- (void)setPrimitiveDtoId:(NSNumber*)value;

- (int32_t)primitiveDtoIdValue;
- (void)setPrimitiveDtoIdValue:(int32_t)value_;

- (NSString*)primitiveImage;
- (void)setPrimitiveImage:(NSString*)value;

- (NSNumber*)primitiveLocation;
- (void)setPrimitiveLocation:(NSNumber*)value;

- (int16_t)primitiveLocationValue;
- (void)setPrimitiveLocationValue:(int16_t)value_;

- (NSNumber*)primitiveOrderNum;
- (void)setPrimitiveOrderNum:(NSNumber*)value;

- (int16_t)primitiveOrderNumValue;
- (void)setPrimitiveOrderNumValue:(int16_t)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

@end

@interface BannerAttributes: NSObject 
+ (NSString *)bgColor;
+ (NSString *)createTime;
+ (NSString *)data;
+ (NSString *)desc;
+ (NSString *)disabled;
+ (NSString *)dtoId;
+ (NSString *)image;
+ (NSString *)location;
+ (NSString *)orderNum;
+ (NSString *)title;
+ (NSString *)url;
@end

NS_ASSUME_NONNULL_END
