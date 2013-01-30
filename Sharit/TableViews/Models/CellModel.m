//
//  CellModel.m
//  Sharit
//
//  Created by Eugene Dorfman on 8/12/12.
//
//

#import "CellModel.h"
#import "TableModelConstants.h"
#import "BaseCellAdapter.h"
#import "BaseCell.h"

@implementation CellModel

- (BaseCell*) createCell {
    BaseCell* cell = nil;
    if ([self.nibName length]) {
        NSArray* nibArray = [[NSBundle mainBundle] loadNibNamed:self.nibName owner:nil options:nil];
        if ([nibArray count]>0) {
            cell = [nibArray objectAtIndex:0];
        }
    } else {
        Class cellClass = [_className length] ? NSClassFromString(_className) : [BaseCell class];
        cell = [[cellClass alloc] initWithStyle:self.style reuseIdentifier:[self identifier]];
    }

    return cell;
}

- (void) setModel:(NSObject *)model {
    _model = model;
}

- (BaseCellAdapter*)cellAdapter {
    BaseCellAdapter* adapter = (BaseCellAdapter*) _adapter;
    adapter.model = _model;
    return adapter;
}

@end