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


// ON ANY OF THE FUNCTIONS THAT CREATES AND RETURNS AN OBJECT IN THE HEAP, HAVE NEW IN THE NAME OF THE FUNCTION
// LIKE INSTEAD OF 'getBooks' WRITE 'getNewBooks'



#import "getData.h"


@implementation GetData{}

+(NSDictionary *) getDataAsDictionary
{
    // Setting up the NSURL object
    NSString *urlString = [NSString stringWithFormat: @"https://www.dropbox.com/s/y24kzlvu1lh5f12/BibleJson.json?dl=1"];
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    // I couldn't assign the value of jsonData when declared without using __block
    // __block lets the declared variable to be modified inside a block
    __block NSData *jsonData = [[NSData alloc] init];

    // Fetching json object as NSData
    NSURLSessionTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           NSLog(@"%@",data);
           jsonData = data;
       }];
    [downloadTask resume];
        
    
    // Simple way of stopping the program until the data is received
    do
    {
        //do nothing
    } while(jsonData.length == 0);      // The data should have some length
    
    
    
    // Coverting NSData with fetched json as a dictionary object
        NSDictionary *bible = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    //    [bible retain];         //Increasing the retain count so that it can be released later
    //
    //    [url release];
    return bible;
}




+(NSMutableArray *) getBooks: (NSDictionary *) bible;
{
    //since this array is being returned, I will have to release this memory in a different function
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
    // Release the following memory in a different place
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
    int verseCount = [chapter intValue];
    // Release the following memory in a different function
    NSMutableArray *allVerses = [[NSMutableArray alloc] initWithCapacity:verseCount];
    for (int i = 0;i<verseCount;i++)
    {
        NSString *verseString = [NSString stringWithFormat:@"%@:%u",prefix,i+1];
        allVerses[i] = verseString;
    }
    return allVerses;
}





// SCENE BASED FUNCTIONS



+(NSMutableArray *) scene1:(NSDictionary *)bible
{
    return [GetData getBooks:bible];
}



+(NSMutableArray *) scene2: (NSDictionary *) bible rowTapped:(int) rowIndex
{
    NSString *key = [NSString stringWithFormat:@"%d",rowIndex+1];        //adding 1 as the book number starts from 1
    NSDictionary *choosenBook = [bible valueForKey:key];
    
    // Getting the arguments for getChapters
    NSString *bookName = [choosenBook valueForKey:@"name"];
    NSDictionary *bookChapters = [choosenBook valueForKey:@"chapters"];

    return [GetData getChapters:bookChapters :bookName];
}



+(NSMutableArray *) scene3: (NSDictionary *) bible rowTapped:(int)rowIndex bookIndex:(int) bookIndex
{
    NSString *bookKey = [NSString stringWithFormat:@"%d",bookIndex+1];
    NSDictionary *choosenBook = [bible valueForKey:bookKey];
    NSDictionary *bookChapters = [choosenBook valueForKey:@"chapters"];
    
    
    NSString *chapterKey = [NSString stringWithFormat:@"%d",rowIndex+1];  //same point as above

    // Arguments for getVerses
    NSString *prefix = [NSString stringWithFormat:@"%@ %d",[choosenBook valueForKey:@"name"],rowIndex+1];
    NSString *choosenChapter = [bookChapters valueForKey:chapterKey];
    
    return [GetData getVerses:choosenChapter :prefix];
}

@end
