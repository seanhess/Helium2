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



@interface HEParser ()

+ (id<HEViewable>) parseXML:(TBXML*)xml;


+ (TBXMLElement*) elementForData:(NSData*)data;
+ (id<HEObject>) parseElement:(TBXMLElement*)element;
+ (NSMutableArray*) parseChildren:(TBXMLElement*)element;
+ (NSMutableDictionary*) parseAttributes:(TBXMLElement*)element;


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

    // TODO: change to support other namespaces
    NSString * className = [NSString stringWithFormat:@"HE%@", [TBXML elementName:element]];
    Class class = NSClassFromString(className);
    id<HEObject> object = [[class new] autorelease];    
 
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
        [attributes removeObjectForKey:@"source"];        
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


/*

        // Will throw an error for an undefined property
        // automatically converts to int for us! hooray!
        
        // [obj setValuesForKeysWithDictionary:dict];
        
        // Class class = [object class];
        // objc_property_t property = class_getProperty(class, [attributeName cStringUsingEncoding:NSUTF8StringEncoding]);
        
        // if (property) {
        //    const char * name = property_getName(property);
        //    const char * infoChars = property_getAttributes(property);
        //    NSLog(@" name=%s info=%s", name, info);
        // }

        // if([object respondsToSelector:setter]) {
        //    [object performSelector:setter withObject:attributeValue];
        // }
        


*/



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




