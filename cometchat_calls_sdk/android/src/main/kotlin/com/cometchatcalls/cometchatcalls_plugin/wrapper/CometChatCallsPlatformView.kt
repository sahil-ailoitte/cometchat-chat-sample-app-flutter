package com.cometchatcalls.cometchatcalls_plugin.wrapper

import android.view.View
import android.widget.RelativeLayout
import io.flutter.plugin.platform.PlatformView


/**
 * Created by Rohit Giri on 21/03/23.
 */
class CometChatCallsPlatformView(
    private val videoContainer: RelativeLayout
) : PlatformView {

    override fun getView(): View {
        return videoContainer
    }

    override fun dispose() {
        videoContainer.removeAllViews()
    }
}