//
//  ToDo.h
//  Deprocrastinator
//
//  Created by Nathan Hosselton on 10/7/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToDo : NSObject

@property NSString *task;
@property UIColor *priority;
@property BOOL isDone;

- (instancetype)initWithTask:(NSString *)task priority:(UIColor *)priority;

@end
