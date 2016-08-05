//
//  RHBSnippets.h
//  RHBSnippets
//
//  Created by Lazar Otasevic on 6/1/16.
//
//

#ifndef RHB_SNIPPETS_H_
#define RHB_SNIPPETS_H_

#define RHB_SINGLETON_IMPLEMENTATION() RHB_SINGLETON_IMPLEMENTATION_WITH_NAME(sharedInstance)
#define RHB_SINGLETON_IMPLEMENTATION_WITH_NAME(NAME) +(instancetype)NAME {static dispatch_once_t pred;static id sharedObject;dispatch_once(&pred,^{sharedObject=[self new];});return sharedObject;}

#endif