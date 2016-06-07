//
//  TBODeveloperOverlayFileInspectorViewController.m
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 09.05.16.
//  Copyright © 2016 TBO INTERACTIVE. All rights reserved.
//

#import "TBODeveloperOverlayFileInspectorViewController.h"

@interface TBODeveloperOverlayFileInspectorViewController () <UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic, readwrite) NSArray *filesAndFolders;
@property (strong, nonatomic, readwrite) UIDocumentInteractionController *documentInteractionViewController;

@end

@implementation TBODeveloperOverlayFileInspectorViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"File Inspector";
    }
    return self;
}

- (instancetype)initWithBaseUrl:(NSURL *)baseUrl {
    self = [self init];
    if (self) {
        self.filesAndFolders = [self filesAndFoldersInFolder:baseUrl];
        self.title = baseUrl.lastPathComponent;
    }
    return self;
}

- (instancetype)initWithBaseUrls:(NSArray<NSURL *> *)baseUrls {
    self = [self init];
    if (self) {
        self.filesAndFolders = baseUrls;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FileOrFolderCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filesAndFolders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *fileOrFolder = self.filesAndFolders[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileOrFolderCell" forIndexPath:indexPath];
    cell.textLabel.text = fileOrFolder.lastPathComponent;
    BOOL isFolder;
    [[NSFileManager defaultManager] fileExistsAtPath:fileOrFolder.path isDirectory:&isFolder];
    if (isFolder) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *fileOrFolder = self.filesAndFolders[indexPath.row];
    BOOL isFolder;
    [[NSFileManager defaultManager] fileExistsAtPath:fileOrFolder.path isDirectory:&isFolder];
    if (isFolder) {
        TBODeveloperOverlayFileInspectorViewController *fileInspector = [[TBODeveloperOverlayFileInspectorViewController alloc] initWithBaseUrl:fileOrFolder];
        [self.navigationController pushViewController:fileInspector animated:YES];
    } else {
        self.documentInteractionViewController = [UIDocumentInteractionController interactionControllerWithURL:fileOrFolder];
        [self.documentInteractionViewController setDelegate:self];
        [self.documentInteractionViewController presentPreviewAnimated:YES];
    }
}

#pragma mark

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

#pragma mark lazy instantiation

- (NSArray<NSURL *> *)filesAndFoldersInFolder:(NSURL *)baseUrl {
    if (!_filesAndFolders) {
        NSMutableArray *filesAndFolders = [NSMutableArray new];
        NSFileManager *fileManager = [NSFileManager new];
        NSDirectoryEnumerator *direnum = [fileManager enumeratorAtURL:baseUrl includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants errorHandler:^BOOL (NSURL *_Nonnull url, NSError *_Nonnull error) {
            return YES;
        }];
        NSString *filename;
        
        while ((filename = [direnum nextObject])) {
            [filesAndFolders addObject:filename];
        }
        _filesAndFolders = filesAndFolders;
    }
    return _filesAndFolders;
}

@end
