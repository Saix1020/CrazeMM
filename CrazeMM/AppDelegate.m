//
//  AppDelegate.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "NewWelcomeViewController.h"
#import "TabBarController.h"
#import "HttpAllRegion.h"
#import "HttpMobileBanner.h"
#import "HttpMobileBanner.h"
#import "Banner.h"

@interface AppDelegate ()
@property (nonatomic, strong) NewWelcomeViewController* welcomeVC;
@property (nonatomic, assign) CFAbsoluteTime resignTime;  //记录进入后台的时间
@property (nonatomic, assign) CFAbsoluteTime currentTime;  //记录进入后台的时间
//@property (nonatomic, strong) Reachability* hostReach;
@property (strong, nonatomic) RealReachability* reachability;
@property (nonatomic) NSUInteger reachabilityCount;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    GLobalRealReachability.hostForPing = FULL_HOSTNAME;
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    //[self getGlobSharedInstances];


    
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(reachabilityChanged:)
//                                                 name: kReachabilityChangedNotification
//                                               object: nil];
//    
//    
//    
//    self.hostReach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
//    [self.hostReach startNotifier];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.welcomeVC = [[NewWelcomeViewController alloc]
                      initWithNibName:nil
                      bundle:nil];
    self.window.rootViewController = self.welcomeVC;
    
    [self.window makeKeyAndVisible];

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self.resignTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    self.currentTime = CFDateGetAbsoluteTime((CFDateRef)[NSDate date]);
    
    if (self.resignTime != 0 && self.currentTime - self.resignTime > 300)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kIntoBackgroundOver5Min object:nil];
    }

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.189.CrazeMM" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CrazeMM" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    // auto migration
    NSDictionary *persistantStoreOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                            [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CrazeMM.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:persistantStoreOptions error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark RealReachability

- (void)networkChanged:(NSNotification *)notification
{
    self.reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [self.reachability currentReachabilityStatus];
    NSLog(@"currentStatus:%@",@(status));
//    self.reachabilityCount++;
//    if (self.reachabilityCount == 1) {
//        return;
//    }
    
//    if(status == RealStatusNotReachable){
////        if (self.welcomeVC.presentedViewController) {
////            [self.welcomeVC.presentingViewController showAlertViewWithMessage:@"网络连接错误, 请检查你的网络"];
////        }
//        if (self.welcomeVC.presentedViewController){
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示"
//                                                            message:@"网络不可用!"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//            [alert show];
//
//        }
//        
//    }
}


#pragma - mark get globshared instance
-(void)getGlobSharedInstances
{
    // all regions
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        [HttpAllRegionRequest getAllRegions];
        [AppDelegate downloadBannerImages];
    });
    
    
    // add more const big data from server here!
    
}

+(void)downloadBannerImages
{
    NSMutableArray* promises = [[NSMutableArray alloc] init];
    NSManagedObjectContext* moc = sharedManagedObjectContext();
    [HttpMobileBannerRequest getAllBanners]
    .then(^(NSArray* newBanners){
        for(BannerDTO* dto in newBanners){
            [promises addObject:[NSURLConnection GET:dto.image]];
            
        }
        PMKJoin(promises).then(^(NSArray* data){
            for(NSArray* detail in data){
                //if (detail.count == 3) {
                    NSHTTPURLResponse* response = detail[1];
                    NSData* imageData = detail[2];
                    for(BannerDTO* dto in newBanners){
                        if ([dto.image isEqualToString:response.URL.absoluteString]) {
                            dto.data = imageData;
                            break;
                        }
                    }
                //}
            }
            
            [Banner removeAllBannersWithManagedObjectContext:moc];
            for(BannerDTO* dto in newBanners){
                [Banner createWithBannerDTO:dto andManagedObjectContext:moc];
                
            }
            [moc save:nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kBannerImagesDownloadSuccessBroadCast object:nil];
            
            //[UserCenter defaultCenter].banners = ;//[nBanners enco];
            
            
            
        });
    });
}


@end
