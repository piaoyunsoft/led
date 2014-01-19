//
//  Font.h
//  Led
//
//  Created by tam on 1/17/14.
//  Copyright (c) 2014 tam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Font : NSObject

@property (nonatomic, strong) NSString *character;
@property (nonatomic) int *code;

- (id) init;

@end
