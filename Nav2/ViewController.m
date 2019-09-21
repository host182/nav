//
//  ViewController.m
//  Nav2
//
//  Created by Poudel, Novel on 9/20/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

{
    NSMutableArray *data;
    int sceneIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // When the app load, it should show the bible books
    NSDictionary* bible = [GetData getDataAsDictionary];
    data = [GetData getBooks:bible];
    
    // At that point, the scene index should be 0
    sceneIndex = 0;
}

// UITavleViewDataSource protocol requires two methods
// (UITableViewCell *) tableView: cellForRowAtIndexPath
// (NSInteger) tableView: numberOfRowsInSection

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusableCell"];
    
//    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = data[indexPath.row];
    
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self changeScene:(int)indexPath];
}

-(void)changeScene: (int) rowIndex{
    sceneIndex++;
    // Copied the following code from https://stackoverflow.com/questions/21660134/can-you-store-functions-in-an-array-in-objective-c
    GetData.funcArray
}

@end
