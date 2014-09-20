//
//  CustomLayout.m
//  TestCollectionView
//
//  Created by 李迪 on 14-7-5.
//  Copyright (c) 2014年 lidi. All rights reserved.
//

#import "CustomLayout.h"

#define SIZE self.collectionView.bounds.size

@implementation CustomLayout

- (void)prepareLayout
{    
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *theLayoutAttributes = [[NSMutableArray alloc] init];

    for( int i = 0; i < self.cellCount; i++ ){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *theAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [theLayoutAttributes addObject:theAttributes];
    }
    
    return [theLayoutAttributes copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(SIZE.width * indexPath.item,0,SIZE.width , SIZE.height);
    
    return attributes;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.cellCount * SIZE.width, SIZE.height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
