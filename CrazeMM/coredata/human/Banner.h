#import "_Banner.h"

#import "BannerDTO.h"

@interface Banner : _Banner
// Custom logic goes here.


+(id)createWithBannerDTO:(BannerDTO*)dto andManagedObjectContext:(NSManagedObjectContext*)moc;

+(NSArray*)allBannersWithManagedObjectContext:(NSManagedObjectContext*)moc;
+(void)removeAllBannersWithManagedObjectContext:(NSManagedObjectContext*)moc;


@end
