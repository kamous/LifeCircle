//
//  ImageCell.m
//  LifeCircle
//
//  Created by kamous on 14-4-4.
//  Copyright (c) 2014年 Jiawen Wang. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,150);
        self.productImageView = [[UIImageView alloc] initWithFrame:self.frame];
        //[self.productImageView setTag:101];
        [self addSubview:self.productImageView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //self.productImageView.frame = self.frame;
    [super drawRect:rect];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
