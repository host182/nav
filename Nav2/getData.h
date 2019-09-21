//
//  getData.h
//  Nav2
//
//  Created by Poudel, Novel on 9/20/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//

#ifndef getData_h
#define getData_h

#import <Foundation/Foundation.h>

@interface GetData: NSObject

//+(NSArray *) getFuncArray;

+(NSDictionary *) getDataAsDictionary;
+(NSMutableArray *) getBooks: (NSDictionary *) bible;
+(NSMutableArray *) getChapters: (NSDictionary *) bookChapters : (NSString *) bookName;
+(NSMutableArray *) getVerses: (NSString *) chapter :(NSString *) prefix;

@end

#endif /* getData_h */
