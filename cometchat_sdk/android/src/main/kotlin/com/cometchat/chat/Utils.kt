package com.cometchat.chat

import com.dart.cometchat.BuildConfig

class Utils {
    fun getSDKVersion(): String{
        return BuildConfig.SDK_VERSION
    }
    fun getPlatform(): String{
        return BuildConfig.PLATFORM
    }
}

