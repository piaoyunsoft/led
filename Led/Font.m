//
//  Font.m
//  Led
//
//  Created by tam on 1/17/14.
//  Copyright (c) 2014 tam. All rights reserved.
//

#import "Font.h"

@implementation Font

- (id) init
{
    _character = @"";
    _code = (int *) malloc(sizeof(int) * 35);
    return self;
}

@end
