//
//  SecondViewController.m
//  TestProject
//
//  Created by Poudel, Novel on 9/27/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [self.data[0] componentsSeparatedByString:@" "][0];
    
//    [self.navigationController.navigationBar setTitleTextAttributes:<#(NSDictionary<NSAttributedStringKey,id> * _Nullable)#>]
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusableCell"];
    
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    rowTapped = (int)indexPath.row;
//}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
// The function below should have '...sender:(id) sender', but since the only segue I have made is from UITableViewCells, I can change the data type of 'sender' without having the chances of running into errors
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ThirdViewController *nextVC = [segue destinationViewController];
       
   int rowTapped = (int)[self.data indexOfObject:sender.textLabel.text];
   
    NSArray *nextData = [GetData scene3:self.bible rowTapped:rowTapped bookIndex:self.rowIndex];
   nextVC.data = nextData;
   nextVC.bible = self.bible;
   nextVC.rowIndex = rowTapped;
    
}


@end
