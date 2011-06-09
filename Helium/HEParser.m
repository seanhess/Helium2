//
//  HEParser.m
//  Helium
//
//  Created by Sean Hess on 6/9/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEParser.h"
#import "TBXML.h"
#import "HEContainer.h"

@interface HEParser ()
+ (void) parseElement:(TBXMLElement*)element object:(id)object;
+ (void) parseChildren:(TBXMLElement*)element object:(id)object;
+ (void) parseAttributes:(TBXMLElement*)element object:(id)object;
+ (void) parseAttribute:(TBXMLAttribute*)attribute object:(id)object;
@end



@implementation HEParser

+ (void) parse:(NSData*)data {

    TBXML * xml = [TBXML tbxmlWithXMLData:data];
    
    id object = nil;
    
    NSString * className = [NSString stringWithFormat:@"HE%@", [TBXML elementName:xml.rootXMLElement]];
    Class class = NSClassFromString(className);
    object = [class new];

    [self parseElement:xml.rootXMLElement object:object];
}

+ (void) parseElement:(TBXMLElement *)element object:(id)object {
    NSLog(@"<%@>", [TBXML elementName:element]);
    [self parseAttributes:element object:object];
    [self parseChildren:element object:object];    
}

+ (void) parseChildren:(TBXMLElement *)element object:(id)object {
    TBXMLElement * child = element->firstChild;

    while(child) {
        [self parseElement:child object:object];
        child = child->nextSibling;
    }        
}

+ (void) parseAttributes:(TBXMLElement *)element object:(id)object { 
    TBXMLAttribute * attribute = element->firstAttribute;
    
    while(attribute) {
        NSLog(@"Attribute %@=%@", [TBXML attributeName:attribute], [TBXML attributeValue:attribute]);
        attribute = attribute->next;
    }        
}

+ (void) parseAttribute:(TBXMLAttribute *)attribute object:(id)object {
    NSLog(@"%@=%@", [TBXML attributeName:attribute], [TBXML attributeValue:attribute]);    
}

@end
