//
//  AppDelegate.h
//  SQLiteFMDB
//
//  Created by proj on 14/3/14.
//  Copyright (c) 2014年 xchobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB/FMDatabase.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FMDatabase *db;

- (BOOL) createTable;

@end
