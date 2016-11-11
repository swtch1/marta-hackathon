//
//  DataManager.m
//  ProjectP
//
//  Created by Darshan Gulur Srinivasa on 8/22/16.
//  Copyright © 2016 Park At Vinings. All rights reserved.
//

#import "DataManager.h"
#import "Booking.h"
#import "Position.h"

@implementation DataManager

+ (instancetype)sharedManager
{
    static DataManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)listOfBookings:(void (^)(NSArray *bookings, NSError *error))block
{
    NSError *deserializingError;
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"bookings" ofType:@"json"];
    NSData *contentOfLocalFile = [NSData dataWithContentsOfFile:pathToFile];
    id object = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                options:NSJSONReadingAllowFragments
                                                  error:&deserializingError];
    
    if (object)
    {
        NSArray *objects = [object objectForKey:@"bookings"];
        __block NSMutableArray *bookings = [[NSMutableArray alloc] init];
        [objects enumerateObjectsUsingBlock:^(NSDictionary *booking, NSUInteger idx, BOOL * _Nonnull stop) {
            [bookings addObject:[[Booking alloc] initWithDictionary:booking]];
        }];
        
        if (block)
        {
            block(bookings, nil);
        }
        else
        {
            block(nil, nil);
        }
    }
    else
    {
        block(nil, nil);
    }
}

- (void)listOfPositions:(void (^)(NSArray *positions, NSError *error))block
{
    NSError *deserializingError;
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"vehicle_data" ofType:@"json"];
    NSData *contentOfLocalFile = [NSData dataWithContentsOfFile:pathToFile];
    id object = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                options:NSJSONReadingAllowFragments
                                                  error:&deserializingError];
    
    if (object)
    {
        NSArray *objects = [object objectForKey:@"1602"];
        __block NSMutableArray *positions = [[NSMutableArray alloc] init];
        [objects enumerateObjectsUsingBlock:^(NSDictionary *position, NSUInteger idx, BOOL * _Nonnull stop) {
            [positions addObject:[[Position alloc] initWithDictionary:position]];
        }];
        
        if (block)
        {
            block(positions, nil);
        }
        else
        {
            block(nil, nil);
        }
    }
    else
    {
        block(nil, nil);
    }
}

@end
