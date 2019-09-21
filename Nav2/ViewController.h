//
//  ViewController.h
//  Nav2
//
//  Created by Poudel, Novel on 9/20/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "getData.h"

// work on making array of functions
// also work on memory management next time

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

-(void) changeScene: (int) rowIndex;

@end

