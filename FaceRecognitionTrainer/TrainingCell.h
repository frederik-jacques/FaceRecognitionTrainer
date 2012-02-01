//
//  TrainingCell.h
//  FaceRecognitionTrainer
//
//  Created by Frederik Jacques on 30/01/12.
//  Copyright (c) 2012 dev-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface TrainingCell : UITableViewCell{
    User *user;
}

@property (nonatomic, retain) User *user;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andUser:(User *)theUser;

@end
