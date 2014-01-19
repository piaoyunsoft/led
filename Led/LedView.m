//
//  LedView.m
//  Led
//
//  Created by tam on 1/17/14.
//  Copyright (c) 2014 tam. All rights reserved.
//

#import "LedView.h"

@implementation LedView

- (id) init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void) awakeFromNib {
    
    self.image = [UIImage imageNamed:@"off"];
    self.highlightedImage = [UIImage imageNamed:@"on"];
    [self setHighlighted:NO];
}
- (void) layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 24, 24);
    
}
- (void) setIsOn:(BOOL)isOn {
    _isOn = isOn;
    [self setHighlighted:isOn];
}


@end
