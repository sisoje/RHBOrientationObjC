//
//  RHBSnippets.h
//  RHBSnippets
//
//  Created by Lazar Otasevic on 6/1/16.
//
//

#ifndef RHB_SNIPPETS_H_
#define RHB_SNIPPETS_H_

#define RHB_SINGLETON_INTERFACE() +(instancetype)sharedInstance
#define RHB_SINGLETON_IMPLEMENTATION() RHB_SINGLETON_INTERFACE() {static dispatch_once_t pred;static id sharedObject;dispatch_once(&pred,^{sharedObject=[self new];});return sharedObject;}
#define RHB_INIT_IMPLEMENTATION(BLOCK) -(instancetype)init {if (self=[super init]) {BLOCK;} return self;}

#endif