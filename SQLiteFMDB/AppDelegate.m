//
//  AppDelegate.m
//  SQLiteFMDB
//
//  Created by proj on 14/3/14.
//  Copyright (c) 2014年 xchobo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

//如果有資料庫就開啓，否則建立後開啓
- (BOOL) openDB{
    // 取得文件資料夾
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"database.db"];
    
    _db = [FMDatabase databaseWithPath:path];
    
    NSLog(@"DB=%@", _db);
    if (_db) {
        NSLog(@"DB Open");
        return 1;
    }else{
        NSLog(@"DB Fail");
    }
    return 0;
}

- (BOOL) createTable{
    [_db open];  //開啓資料庫連線
    
    NSString *sql =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS User(%@ text primary key, %@ text)",
                    @"name", @"age"];
    BOOL check = [_db executeUpdate:sql];
    if (check) {
        NSLog(@"create OK");
    }else{
        NSLog(@"create Fail");
    }
    [_db close];   //關閉資料庫連線
    return check;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // -application:didFinishLaunchingWithOptions
    //開啓資料庫
    [self openDB];
    
    // 建立資料表
    [self createTable];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
