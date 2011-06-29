//
//  HELoader.m
//  Helium
//
//  Created by Sean Hess on 6/21/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HELoader.h"
#import "HEParser.h"

@implementation HELoader

+ (id<HEObject>) loadPageFromFile:(NSString*)file {
    NSData * data = [self dataFromFile:file];
    id<HEViewControllable> page = (id<HEViewControllable>)[HEParser parseData:data];
    return page;
}

+ (NSData*) dataFromFile:(NSString*)file {
    NSString * extension = [file pathExtension];
    NSString * basename = [file stringByDeletingPathExtension];
    NSString * path = [[NSBundle mainBundle] pathForResource:basename ofType:extension];
    NSData * data = [NSData dataWithContentsOfFile:path];
    return data;
}

@end
