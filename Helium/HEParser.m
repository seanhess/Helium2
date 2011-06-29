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

+ (id<HEViewable>) parseXML:(TBXML*)xml;

+ (id<HEObject>) parseElement:(TBXMLElement*)element;
+ (void) parseChildren:(TBXMLElement*)element object:(id<HEObject>)object;
+ (void) parseAttributes:(TBXMLElement*)element object:(id<HEObject>)object;

+ (NSString *)propertyType:(id)object attributeName:(NSString*)name;
@end



@implementation HEParser

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
    // NSLog(@"<%@>", [TBXML elementName:element]);
    
    id<HEObject> object = nil;

    // TODO: change to support other namespaces
    NSString * className = [NSString stringWithFormat:@"HE%@", [TBXML elementName:element]];
    Class class = NSClassFromString(className);
    object = [[class new] autorelease];
    
    // attaches to it
    [self parseAttributes:element object:object];
    
    // attaches to it
    [self parseChildren:element object:object];
    
    // Tell it we are done
    [object didInitialize];
    
    return object;
}

+ (void) parseChildren:(TBXMLElement *)element object:(id<HEParent>)object {
    
    TBXMLElement * child = element->firstChild;

    while(child) {
        id<HEObject> childObject = [self parseElement:child];
        [object addChild:childObject];
        child = child->nextSibling;
    }        
}

+ (void) parseAttributes:(TBXMLElement *)element object:(id<HEObject>)object { 
    TBXMLAttribute * attribute = element->firstAttribute;
    
    while(attribute) {
        NSString * attributeName = [TBXML attributeName:attribute];
        id attributeValue = [TBXML attributeValue:attribute];
        
        // Will throw an error for an undefined property
        // automatically converts to int for us! hooray!
        @try {
            
            NSString * type = [self propertyType:object attributeName:attributeName];
            
            if ([type isEqualToString:@"NSNumber"]) {
                // Only accept integers
                attributeValue = [NSNumber numberWithInt:[attributeValue intValue]];
            }
            
            [object setValue:attributeValue forKey:attributeName];
        }
        @catch (NSException * e) {
            NSLog(@"NO PROPERTY %@ on %@", attributeName, object);
        }
        
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
        
        attribute = attribute->next;        
    }        
}


// taken from http://stackoverflow.com/questions/754824/get-an-object-attributes-list-in-objective-c
// pulls out the property type

+ (NSString *)propertyType:(id)object attributeName:(NSString *)name {
    objc_property_t property = class_getProperty([object class], [name cStringUsingEncoding:NSUTF8StringEncoding]);
    
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




