//
//  TypesetKit+Color.m
//  Typeset
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import "TypesetKit+Color.h"

@implementation TypesetKit (Color)

- (TypesetKit *)black {
    return self.color([UIColor blackColor]);
}

- (TypesetKit *)darkGray {
    return self.color([UIColor darkGrayColor]);
}

- (TypesetKit *)lightGray {
    return self.color([UIColor lightGrayColor]);
}

- (TypesetKit *)white {
    return self.color([UIColor whiteColor]);
}

- (TypesetKit *)gray {
    return self.color([UIColor grayColor]);
}

- (TypesetKit *)red {
    return self.color([UIColor redColor]);
}

- (TypesetKit *)green {
    return self.color([UIColor greenColor]);
}

- (TypesetKit *)blue {
    return self.color([UIColor blueColor]);
}

- (TypesetKit *)cyan {
    return self.color([UIColor cyanColor]);
}

- (TypesetKit *)yellow {
    return self.color([UIColor yellowColor]);
}

- (TypesetKit *)magenta {
    return self.color([UIColor magentaColor]);
}

- (TypesetKit *)orange {
    return self.color([UIColor orangeColor]);
}

- (TypesetKit *)purple {
    return self.color([UIColor purpleColor]);
}

- (TypesetKit *)brown {
    return self.color([UIColor brownColor]);
}

- (TypesetKit *)clear {
    return self.color([UIColor clearColor]);
}

@end
