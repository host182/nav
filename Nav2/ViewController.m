//
//  ViewController.m
//  TestProject
//
//  Created by Poudel, Novel on 9/27/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *data;
    NSDictionary *bible;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Creating a spinner until the data loads
    
    // Getting the size of the screen
    CGSize screenSize = [UIScreen.mainScreen bounds].size;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] init];
    // Adding the spinner in the center
    spinner.center = CGPointMake(screenSize.width/2,screenSize.height/2);
    [self.view addSubview:spinner];
    [spinner startAnimating];
    

    [GetData getDataAsDictionary:^(NSDictionary *result) {
//        // making sure the spinner is shown
//        [NSThread sleepForTimeInterval:5];
        

        self->bible = result;
        self->data = [GetData getBooks:result];
        
        //REMEMBER, A SECONDARY THREAD CANNOT ACCESS UI ELEMENTS
        dispatch_async(dispatch_get_main_queue(),^ {
            [self.tableView reloadData];
            //hiding the spinner
            [spinner stopAnimating];
//            [spinner release];
        });
    }];
    
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusableCell"];
    
    cell.textLabel.text = data[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
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
    SecondViewController *nextVC = [segue destinationViewController];
    
    int rowTapped = (int)[data indexOfObject:sender.textLabel.text];
    NSLog(@"%d", rowTapped);
    
    NSArray *nextData = [GetData scene2:bible rowTapped:rowTapped];
    nextVC.data = nextData;
    nextVC.bible = bible;
    nextVC.rowIndex = rowTapped;
}


//-(void) dealloc{
//    [bible release];
//    [data release];
//    [super dealloc];
//}


@end
