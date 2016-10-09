#import "Banner.h"

@interface Banner ()

// Private interface goes here.

@end

@implementation Banner

// Custom logic goes here.
+(id)createWithBannerDTO:(BannerDTO*)dto andManagedObjectContext:(NSManagedObjectContext*)moc
{
    Banner* b = [Banner insertInManagedObjectContext:moc];
    if (b) {
        b.image = dto.image;
        b.bgColor = dto.bgColor;
        b.createTime = dto.createTime;
        b.orderNum = [NSNumber numberWithInt:(int)dto.orderNum];
        b.disabled = [NSNumber numberWithBool:dto.disabled];
        b.location = [NSNumber numberWithInt:(int)dto.location];
        b.dtoId = [NSNumber numberWithInt:(int)dto.id];
        b.title = dto.title;
        b.url = dto.url;
        b.desc = dto.desc;
        b.data = dto.data;
    }
    return b;
}

+(NSArray*)allBannersWithManagedObjectContext:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *bannerEntity = [NSEntityDescription entityForName:[Banner entityName] inManagedObjectContext:moc];
    [fetchRequest setEntity:bannerEntity];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", teamName];
//    [fetchRequest setPredicate:predicate];
//    [fetchRequest setFetchLimit:1];
    
    NSError *error = NULL;
    NSArray *array = [moc executeFetchRequest:fetchRequest error:&error];

    return array;
}

+(void)removeAllBannersWithManagedObjectContext:(NSManagedObjectContext*)moc
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *bannerEntity = [NSEntityDescription entityForName:[Banner entityName] inManagedObjectContext:moc];
    [fetchRequest setEntity:bannerEntity];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        NSBatchDeleteRequest* request = [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
        [moc executeRequest:request error:nil];
    }
    else {
        NSArray *array = [moc executeFetchRequest:fetchRequest error:nil];
        for (Banner* banner in array) {
            [moc deleteObject:banner];
        }
    }
    
    [moc save:nil];
    
}


@end
