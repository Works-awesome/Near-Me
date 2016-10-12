//
//  CoolButton.m
//  CoolButton
//
//  Created by Brian Moakley on 2/21/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import "CoolButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation CoolButton

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor redColor];
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
        self.layer.cornerRadius=10.f;
    
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius=10.f;
    
}




@end