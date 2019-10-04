//
//  getData.h
//  Nav2
//
//  Created by Poudel, Novel on 9/20/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//

//Static methods cannot reference to the variables using self.<variable_name>

#ifndef getData_h
#define getData_h

#import <Foundation/Foundation.h>

@interface GetData: NSObject


+(void) getDataAsDictionary:(void (^)(NSDictionary *result))completion;
+(NSMutableArray *) getBooks: (NSDictionary *) bible;
+(NSMutableArray *) getChapters: (NSDictionary *) bookChapters : (NSString *) bookName;
+(NSMutableArray *) getVerses: (NSString *) chapter :(NSString *) prefix;

+(NSMutableArray *) scene1: (NSDictionary *) bible;
+(NSMutableArray *) scene2: (NSDictionary *) bible rowTapped:(int) rowIndex;
+(NSMutableArray *) scene3: (NSDictionary *) bible rowTapped:(int) rowIndex bookIndex:(int) bookIndex;

@end

#endif /* getData_h */
