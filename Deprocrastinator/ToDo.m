//
//  ToDo.m
//  Deprocrastinator
//
//  Created by Nathan Hosselton on 10/7/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTask:(NSString *)task priority:(UIColor *)priority
{
    self = [super init];

    if (task.length == 0)
    {
        // Handle this somehow
    }
    else
    {
        self.task = task;
    }

    if (priority == nil)
    {
        self.priority = [UIColor blackColor];
    }
    else
    {
        self.priority = priority;
    }

    self.isDone = NO;

    return self;
}

@end
