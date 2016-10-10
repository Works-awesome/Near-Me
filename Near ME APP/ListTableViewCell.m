//
//  ListTableViewCell.m
//  Near ME APP
//
//  Created by Arjun Hanswal on 10/10/16.
//  Copyright © 2016 Com.BLE  TestApp. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.imageview.layer.borderColor=[UIColor redColor].CGColor;
    self.imageview.layer.cornerRadius=10.0f;
    self.imageview.layer.borderWidth=2.0f;
    self.imageview.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
