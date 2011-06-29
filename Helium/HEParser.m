//
//  HEParser.m
//  Helium
//
//  Created by Sean Hess on 6/9/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEParser.h"
#import "HEContainer.h"
#import "HELoader.h"
#import "TBXML.h"
#import "HEAdapter.h"



@interface HEParser ()

+ (id<HEViewable>) parseXML:(TBXML*)xml;


+ (TBXMLElement*) elementForData:(NSData*)data;
+ (id<HEObject>) parseElement:(TBXMLElement*)element;
+ (NSMutableArray*) parseChildren:(TBXMLElement*)element;
+ (NSMutableDictionary*) parseAttributes:(TBXMLElement*)element;

+ (id<HEObject>)objectForElementName:(NSString*)nodeName;

+ (void)object:(id<HEObject>)object setAttributes:(NSDictionary*)attributes;
+ (void)object:(id<HEObject>)object setChildren:(NSArray*)children;

+ (NSString *)propertyType:(Class)class attributeName:(NSString*)name;
@end



@implementation HEParser

+ (TBXMLElement*) elementForData:(NSData*)data {
    return [[TBXML tbxmlWithXMLData:data] rootXMLElement];
}

+ (id<HEObject>) parseData:(NSData*)data {
    return [self parseXML:[TBXML tbxmlWithXMLData:data]];
}

+ (id<HEObject>) parseString:(NSString*)string {
    return [self parseXML:[TBXML tbxmlWithXMLString:string]];
}

+ (id<HEViewable>) parseXML:(TBXML*)xml {
    return (id<HEViewable>)[self parseElement:xml.rootXMLElement];
}

+ (id<HEObject>) parseElement:(TBXMLElement *)element {

    id<HEObject>object = [self objectForElementName:[TBXML elementName:element]];
 
    // attaches to it
    NSMutableDictionary * attributes = [self parseAttributes:element];
    
    // attaches to it
    NSArray * children = [self parseChildren:element];
    
    // Check Source
    NSString * load = [attributes objectForKey:@"load"];
    if (load) {
        
        NSLog(@"LOADING USING LOAD %@", load);
        // load the object remotely
        NSData * data = [HELoader dataFromFile:load];
        TBXMLElement * sourceElement = [self elementForData:data];
        
        NSMutableDictionary * sourceAttributes = [self parseAttributes:sourceElement];
        NSMutableArray * sourceChildren = [self parseChildren:sourceElement];
        
        // overwrites old values
        [attributes removeObjectForKey:@"load"];        
        [sourceAttributes addEntriesFromDictionary:attributes];
        [sourceChildren addObjectsFromArray:children];
        
        attributes = sourceAttributes;
        children = sourceChildren;
    }
    
    [self object:object setAttributes:attributes];
    [self object:object setChildren:children];    
    
    [object didInitialize];

    return object;
}

+ (NSMutableArray*) parseChildren:(TBXMLElement *)element {

    NSMutableArray * children = [NSMutableArray array];
    
    TBXMLElement * child = element->firstChild;

    while(child) {
        id<HEObject> childObject = [self parseElement:child];
        [children addObject:childObject];
        child = child->nextSibling;
    }        
    
    return children;
}

+ (NSMutableDictionary*) parseAttributes:(TBXMLElement *)element { 
    TBXMLAttribute * attribute = element->firstAttribute;
    NSMutableDictionary * values = [NSMutableDictionary dictionary];
    
    while(attribute) {
        NSString * attributeName = [TBXML attributeName:attribute];
        id attributeValue = [TBXML attributeValue:attribute];
        [values setObject:attributeValue forKey:attributeName];        
        attribute = attribute->next;        
    }  

    return values;      
}




+ (id<HEObject>)objectForElementName:(NSString*)nodeName {

    // see if a built-in HE object exists with that name, otherwise, 
    // try loading it as an HEObject, and if it fails, then load using 
    // an adapter. 
    
    // Ignore namespacing, since iOS requires you to namespace your classes
    // anyway. 

    NSString * className = [NSString stringWithFormat:@"HE%@", nodeName];
    Class class = NSClassFromString(className);
    id<HEObject> object = nil;
    
    // Try a class with a non-HE prefix
    if (!class) 
        class = NSClassFromString(nodeName);
    
    // If it's already an HEObject, just go for it
    if ([class conformsToProtocol:@protocol(HEObject)])
        object = [[class new] autorelease];   
        
    // Otherwise, use an adapter
    else {
        NSLog(@"USing adapter for %@", NSStringFromClass(class));
        HEAdapter * adapter = [[HEAdapter new] autorelease];
        adapter.type = class;
        object = adapter;                
    }
    
    return object;
}



+ (void)object:(id<HEObject>)object setAttributes:(NSDictionary*)attributes {
    for (NSString * name in attributes) {
        @try {

            id value = [attributes objectForKey:name];
            
            NSString * type = [self propertyType:[object class] attributeName:name];
            
            if ([type isEqualToString:@"NSNumber"]) {
                // Only accept integers
                value = [NSNumber numberWithInt:[value intValue]];
            }
            
            [object setValue:value forKey:name];
        }
        @catch (NSException * e) {
            NSLog(@"NO PROPERTY %@ on %@", name, NSStringFromClass([object class]));
        }        
    }
}

+ (void)object:(id<HEObject>)object setChildren:(NSArray*)children {
    object.children = children;
}







// taken from http://stackoverflow.com/questions/754824/get-an-object-attributes-list-in-objective-c
// pulls out the property type

+ (NSString *)propertyType:(Class)class attributeName:(NSString *)name {
    objc_property_t property = class_getProperty(class, [name cStringUsingEncoding:NSUTF8StringEncoding]);
    
    if (!property) return nil;
    
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return [NSString stringWithCString:(const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes] encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

@end




