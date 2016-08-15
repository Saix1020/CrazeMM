#import "SearchHistory.h"

@interface SearchHistory ()

// Private interface goes here.
@property (nonatomic, readonly) NSManagedObjectContext* nanagedObjectContext;

@end

@implementation SearchHistory

// Custom logic goes here.


-(NSManagedObjectContext*)managedObjectcontent
{
    return sharedManagedObjectContext();
}


+(void)createIfNotExist:(NSString*)keyword andManagedObjectContext:(NSManagedObjectContext*)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[SearchHistory entityName] inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"keyword == %@", keyword];
    [fetchRequest setPredicate:predicate];
    NSArray *searchHistorys = [context executeFetchRequest:fetchRequest error:nil];
    if (searchHistorys.count == 0) {
        SearchHistory* searchHistory = [SearchHistory insertInManagedObjectContext:context];
        searchHistory.keyword = keyword;
        [context save:nil];
    }
}

+(NSArray*)findAll:(NSManagedObjectContext*)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[SearchHistory entityName] inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *searchHistorys = [context executeFetchRequest:fetchRequest error:nil];
    return searchHistorys;
}

+(NSArray*)findWithPredicate:(NSPredicate*)predicate andManagedObjectContext:(NSManagedObjectContext*)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:[SearchHistory entityName] inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *searchHistorys = [context executeFetchRequest:fetchRequest error:nil];
    
    return searchHistorys;
}

+(void)removeAll:(NSManagedObjectContext*)context
{
    NSArray* all = [SearchHistory findAll:context];
    for (NSManagedObject* obj in all) {
        [context deleteObject:obj];
    }
    
    [context save:nil];
}

@end
