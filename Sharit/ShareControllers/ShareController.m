//
//  ShareController.m
//  Sharit
//
//  Created by Eugene Dorfman on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShareController.h"
#import "Share.h"
#import "ClipboardShare.h"
#import "TextShare.h"
#import "PicturesShare.h"
#import "ClipboardShareController.h"
#import "TextShareController.h"
#import "PicturesShareController.h"
#import "ShareSwitchCellAdapter.h"

@interface ShareController ()

@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.share.name;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

+ (ShareController*) controllerWithShare:(Share*)share {
    NSDictionary* controllerToShare = @{
        (id<NSCopying>)[ClipboardShare class] : [ClipboardShareController class],
        (id<NSCopying>)[TextShare class] : [TextShareController class],
        (id<NSCopying>)[PicturesShare class] : [PicturesShareController class]
    };

    ShareController* shareController = nil;
    Class controllerClass = [controllerToShare objectForKey:[share class]];
    if (Nil!=controllerClass) {
        shareController = [[controllerClass alloc] initWithStyle:UITableViewStyleGrouped];
        shareController.share = share;
    }

    return shareController;
}

- (void) sharesRefreshed {
    
}

- (void)switchValueChanged:(UISwitch*)sender {
    self.share.isShared = sender.isOn;
}

- (void)setShare:(Share *)share {
    _share = share;
    self.tableModel = [TableModel new];
    [self initTableModel];
}

- (void) initTableModel {
    [self.tableModel addSection:@{
                         kCells: @[
     @{
                kCellClassName : @"SwitchCell",
                kNibNameToLoad : @"SwitchCell",
                      kAdapter : [ShareSwitchCellAdapter new],
                        kModel : self.share
     }
     ]
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableModel tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.tableModel tableView:tableView titleForHeaderInSection:section];
}

@end