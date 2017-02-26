//
//  Process.m
//  ProjectP
//
//  Created by Darshan Gulur Srinivasa on 9/14/16.
//  Copyright © 2016 Park At Vinings. All rights reserved.
//

#import "Booking.h"

@implementation Booking
@synthesize bookingID;
@synthesize date;
@synthesize readyTime;
@synthesize windowEnd;
@synthesize pickupAddress;
@synthesize dropOffAddress;
@synthesize status;

- (instancetype)initWithDictionary:(NSDictionary *)bookingDictionary
{
    if (bookingDictionary)
    {
        Booking *booking = [[Booking alloc] init];
        booking.bookingID = [bookingDictionary objectForKey:@"bookingID"];
        booking.date = [bookingDictionary objectForKey:@"date"];
        booking.readyTime = [bookingDictionary objectForKey:@"readyTime"];
        booking.windowEnd = [bookingDictionary objectForKey:@"windowEnd"];
        booking.pickupAddress = [bookingDictionary objectForKey:@"pickupAddress"];
        booking.dropOffAddress = [bookingDictionary objectForKey:@"dropOffAddress"];
        booking.status = [bookingDictionary objectForKey:@"status"];
        return booking;
    }
    
    return nil;
}

@end
