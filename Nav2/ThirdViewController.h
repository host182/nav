//
//  ThirdViewController.h
//  TestProject
//
//  Created by Poudel, Novel on 9/27/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>


@property (strong) NSArray *data;
@property (strong) NSDictionary *bible;
@property int rowIndex;

@end

NS_ASSUME_NONNULL_END
