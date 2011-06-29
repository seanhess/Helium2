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
    return [self loadPageFromData:[self dataFromFile:file]];
}

+ (id<HEObject>) loadPageFromURL:(NSString*)url {
    return [self loadPageFromData:[self dataFromURL:url]];    
}

+ (id<HEObject>) loadPageFromData:(NSData *)data {
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

+ (NSData*) dataFromURL:(NSString*)url {

    // I need to support relative urls, but for now, global
    NSURL * nativeUrl = [NSURL URLWithString:url];
    return [NSData dataWithContentsOfURL:nativeUrl];
}

@end
