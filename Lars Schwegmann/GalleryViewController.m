//
//  GalleryViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 12.04.14.
//
//

//------------------------------------------------------------------------------------

#import "GalleryViewController.h"

//------------------------------------------------------------------------------------

@interface GalleryViewController ()

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) YSViewer *imageViewer;

@end

//------------------------------------------------------------------------------------

@implementation GalleryViewController

//------------------------------------------------------------------------------------
#pragma mark - UIViewcontroller Methods
//------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _imageViewer = [[YSViewer alloc] init];
    
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------------
#pragma mark - Navigation
//------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

//------------------------------------------------------------------------------------
#pragma mark - UICollectionViewDataSource
//------------------------------------------------------------------------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    UIImage *cellContents = [_images objectAtIndex:indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:10];
    imageView.image = cellContents;
    
    return cell;
}

- (void)setImageBundleName:(NSString *)imageBundleName{
    _imageBundleName = imageBundleName;
    
    //Load Images
    [_images removeAllObjects];
    _images = [[NSMutableArray alloc] init];
    NSBundle *imageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:_imageBundleName ofType:@"bundle"]];
    if (imageBundle != nil){
        NSArray *bundleContents = [imageBundle pathsForResourcesOfType:@"png" inDirectory:nil];
        for (NSString *path in bundleContents){
            [_images addObject:[UIImage imageWithContentsOfFile:path]];
        }
    }
    [_collectionView reloadData];
}

//------------------------------------------------------------------------------------
#pragma mark - UICollectionViewDelegate
//------------------------------------------------------------------------------------

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
    UIImage *imageToDisplay = [(UIImageView *)[cell viewWithTag:10] image];
    _imageViewer.image = imageToDisplay;
    [_imageViewer show];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UIView *highlightView = (UIView *)[[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:20];
    [UIView animateWithDuration:0.1f animations:^{
        highlightView.alpha = 0.3f;
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UIView *highlightView = (UIView *)[[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:20];
    [UIView animateWithDuration:0.1f animations:^{
        highlightView.alpha = 0.0f;
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
