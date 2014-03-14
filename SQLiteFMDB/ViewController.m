//
//  ViewController.m
//  SQLiteFMDB
//
//  Created by proj on 14/3/14.
//  Copyright (c) 2014年 xchobo. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController (){
    AppDelegate *app;
}
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *ageField;

@property (strong, nonatomic) NSMutableArray *dataArr;

- (IBAction)insertData:(id)sender;
- (IBAction)checkData:(id)sender;

- (IBAction)updataData:(id)sender;
- (IBAction)deleteData:(id)sender;



@end

@implementation ViewController

- (IBAction)insertData:(id)sender {
    [app.db open];
    
    //取得資料
    NSString *nameStr = [_nameField text];
    NSString *ageStr = [_ageField text];
    
    //SQL語法
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO User VALUES ('%@', '%@')",nameStr, ageStr];
    BOOL check = [app.db executeUpdate:sql];
    
    if (check) {
        NSLog(@"Insert OK");
    }else{
        NSLog(@"Insert Fail");
    }
    
    [app.db close];
}

- (IBAction)checkData:(id)sender {
    [app.db open];
    
    [_dataArr removeAllObjects]; //先清空
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", @"User"];
    // FMDB的查詢
    FMResultSet *dataSet = [app.db executeQuery:sql];
    
    if (dataSet) {
        while([dataSet next]) {
            // 建立暫存用陣列
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            [tempArr addObject:[dataSet stringForColumn:@"name"]];
            [tempArr addObject:[dataSet stringForColumn:@"age"]];
            
            // 將資料儲存下來
            [_dataArr addObject:tempArr];
        }
    }else{
        NSLog(@"查無資料");
    }
    
    // test
    NSLog(@"DB get= %@", _dataArr);
    
    [app.db close];
}

- (IBAction)updataData:(id)sender {
    [app.db open];
    
    //找到name為Xchobo，將其age改為21
    NSString *sql = [NSString stringWithFormat:@"UPDATE User SET age = %@ WHERE name = '%@'", @"21", @"Xchobo"];
    BOOL check = [app.db executeUpdate:sql];
    
    if (check) {
        NSLog(@"Updata OK");
    }else{
        NSLog(@"Updata Fail");
    }
    
    [app.db  close];
}

- (IBAction)deleteData:(id)sender {
    [app.db open];

    //刪除User資料表中所有age為30的資料
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM User WHERE age = %@", @"30"];
    BOOL check = [app.db executeUpdate:sql];
    
    if (check) {
        NSLog(@"delete OK");
    }else{
        NSLog(@"delete Fail");
    }
    [app.db close];
}

// 初始
- (void) viewDidAppear:(BOOL)animated{
    // -viewDidAppear
    // 讀取 AppDelegate 中的資料庫物件
    app = [[UIApplication sharedApplication] delegate];
    _dataArr = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}


@end
