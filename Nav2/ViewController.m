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
    NSDictionary *bible;            // storing this so that internet is only needed at the time of load
    NSMutableArray *data;           // the information displayed in the screen is from this Array
    int sceneIndex;
    // Storing these three integers to keep track of the location
    NSMutableArray *indeces;                 //stores bookIndex, chapterIndex and verseIndex in order
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSLog(@"Begin");
//    dispatch_block_t testBlock = ^
//    {
//        NSLog(@"In block");
//    };
//
//
//    NSMutableArray<NSBlockOperation *> *ops = [NSMutableArray array];
//    for (int i = 0; i < 10; i++)
//    {
//        [ops addObject:[NSBlockOperation blockOperationWithBlock:^{
//            NSLog(@"Item %i", i);
//        }]];
//    }
//    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"In NSObject block!");
//    }];
//
//    [op start];
//
//    NSLog(@"end");
//
//    testBlock();
    
    // When the app load, it should show the bible books
    bible = [GetData getDataAsDictionary];
    data = [GetData getBooks:bible];
    indeces = [[NSMutableArray alloc] init];
    
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
    NSNumber *rowIndex = [NSNumber numberWithInt:(int)indexPath.row];
    [self changeScene:tableView rowTapped:rowIndex];
}



-(void)changeScene: (UITableView *) tableView rowTapped:(NSNumber *)rowIndex{                 // rowIndex when pressed back is -1
    // Getting a NSNumber so that we can add that to the NSMutableArray
    NSLog(@"%d",[rowIndex intValue]);
    
    // Changing the sceneIndex and location indeces
    if (([rowIndex intValue]!= -1)&&(sceneIndex<3))
    {
        sceneIndex++;
        [indeces addObject:rowIndex];
    }
    else if ([rowIndex intValue]==1)
    {
        if(sceneIndex>0)
        {
            sceneIndex--;
            [indeces removeLastObject];
        }
    }
    
    [data release];
    
    // getting the data based on the scene
    if (sceneIndex == 0)
        data = [GetData scene1:bible];
    else if(sceneIndex == 1)
        data = [GetData scene2:bible rowTapped:[rowIndex intValue]];
    else if(sceneIndex == 2)
        data = [GetData scene3:bible rowTapped:[rowIndex intValue] bookIndex:[indeces[0] intValue]];

    // This code refreshes the screen
    [tableView reloadData];
    
    NSLog(@"%d",sceneIndex);
    NSLog(@"%@",data);
    
}


// deallocating the memory used
-(void) dealloc
{
    [indeces release];
    [bible release];
    [data release];
    [super dealloc];
}

@end
