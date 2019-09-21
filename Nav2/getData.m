//
//  getData.m
//  Nav2
//
//  Created by Poudel, Novel on 9/20/19.
//  Copyright © 2019 Poudel, Novel. All rights reserved.
//
// Deserializing json objects - https://stackoverflow.com/questions/36893062/deserialize-json-using-objective-c-into-a-custom-object
//
// Creating an array of functions. This array will have [getbooks, getChapters and getVerses] - https://stackoverflow.com/questions/21660134/can-you-store-functions-in-an-array-in-objective-c

#import "getData.h"


@implementation GetData{}

+(NSDictionary *) getDataAsDictionary
{
    // Setting up the NSURL object
    NSString *urlString = [NSString stringWithFormat: @"https://www.dropbox.com/s/y24kzlvu1lh5f12/BibleJson.json?dl=1"];
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    // Fetching json object as NSData
    NSData *jsonData = [NSData dataWithContentsOfURL: url];

    // Coverting NSData with fetched json as a dictionary object
    NSDictionary *bible = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];

    return bible;
}

+(NSMutableArray *) getBooks: (NSDictionary *) bible;
{
    NSMutableArray *allBooks = [[NSMutableArray alloc] initWithCapacity:66];

    for (int i = 0;i<66;i++)
    {
        NSString *key = [NSString stringWithFormat:@"%d",i+1];

        // Searching for keys with the book number (1 to 66)
        NSDictionary *thisBook = [bible valueForKey:key];

        // Adding the books that are found
        allBooks[i] = [thisBook valueForKey:@"name"];
    }

    return allBooks;
}

+(NSMutableArray *) getChapters: (NSDictionary *) bookChapters : (NSString *) bookName;
{
    NSMutableArray *allChapters = [[NSMutableArray alloc] initWithCapacity:bookChapters.count];

    for (int i = 0;i<bookChapters.count;i++)
    {
        // use of "%@" and "%u" - https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
        NSString *chapterString = [NSString stringWithFormat:@"%@ %u",bookName,i+1];
        allChapters[i] = chapterString;
    }
    return allChapters;
}

+(NSMutableArray *) getVerses: (NSString *) chapter : (NSString *)prefix
{
    int verseCount = [chapter integerValue];
    NSMutableArray *allVerses = [[NSMutableArray alloc] initWithCapacity:verseCount];
    for (int i = 0;i<verseCount;i++)
    {
        NSString *verseString = [NSString stringWithFormat:@"%@:%u",prefix,i+1];
        allVerses[i] = verseString;
    }
    return allVerses;
}

//+(NSArray *) getFuncArray{
//    NSArray *funcArray = [NSArray arrayWithObjects:@getBooks, nil]
//}

@end
