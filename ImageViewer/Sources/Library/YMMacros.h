//
//  YMMacros.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#define YMWeakify(object) \
__weak __typeof(object) __YMWeak_##object = object

#define YMStrongify(object) \
__strong __typeof(__YMWeak_##object) object = __YMWeak_##object
