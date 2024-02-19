import 'dart:async';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:cometchat_uikit_shared/src/views/media_recorder/_audio_visualizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

///[CometChatMediaRecorder] is a class that allows users to record audio  messages.
///It has a start button to start recording, a stop button to stop recording, a play button to play the recorded message, a pause button to pause the recorded message, a submit button to submit the recorded message and a close button to close the media recorder.
///
/// ```dart
/// CometChatMediaRecorder(
///  startIcon: Icon(Icons.mic),
///  playIcon: Icon(Icons.play_arrow),
///  pauseIcon: Icon(Icons.pause),
///  closeIcon: Icon(Icons.close),
///  stopIcon: Icon(Icons.stop),
///  submitIcon: Icon(Icons.send),
///  onSubmit: (BuildContext, String path) {
///  print("recording is in: $path");
///  },
///  onClose: () {
///  print("Closed");
///  },
///  mediaRecorderStyle: MediaRecorderStyle(
///  pauseIconTint: Colors.red,
///  playIconTint: Colors.green,
///  closeIconTint: Colors.red,
///  timerTextStyle: TextStyle(color: Colors.white),
///  submitIconTint: Colors.green,
///  startIconTint: Colors.green,
///  stopIconTint: Colors.red,
///  audioBarTint: Colors.green,
///  ),
///  );
///  ```
///
class CometChatMediaRecorder extends StatefulWidget {
  const CometChatMediaRecorder(
      {Key? key,
      this.startIcon,
      this.playIcon,
        this.pauseIcon,
      this.closeIcon,
      this.stopIcon,
      this.submitIcon,
      this.onSubmit,
      this.onClose,
      this.mediaRecorderStyle,
        this.theme
      })
      : super(key: key);

  ///[startIcon] provides icon to the start Icon/widget
  final Widget? startIcon;

  ///[playIcon] provides icon to the play Icon/widget
  final Widget? playIcon;

  ///[pauseIcon] provides icon to the play Icon/widget
  final Widget? pauseIcon;
  
  ///[closeIcon] provides icon to the close Icon/widget
  final Widget? closeIcon;

  ///[stopIcon] provides icon to the stop Icon/widget
  final Widget? stopIcon;
  
  ///[submitIcon] provides icon to the submit Icon/widget
  final Widget? submitIcon;
  
  ///[onSubmit] provides callback to the submit Icon/widget
  final Function(BuildContext,String)? onSubmit;
  
  ///[onClose] provides callback to the close Icon/widget
  final Function? onClose;
  
  ///[mediaRecorderStyle] provides style to the media recorder
  final MediaRecorderStyle? mediaRecorderStyle;

  ///[theme] provides theme to the media recorder
  final CometChatTheme? theme;
  @override
  State<CometChatMediaRecorder> createState() => _CometChatMediaRecorderState();
}

class _CometChatMediaRecorderState extends State<CometChatMediaRecorder> {
  late CometChatTheme _theme;
  String? path;
  bool _isRecording = false;
  bool _isAudioRecordingCompleted = false;
  late Timer _timer;
  bool _isPlaying = false;

  Duration _elapsedTime = Duration.zero;

Widget? audioBar;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme ?? cometChatTheme;
    startRecording();
  }

  @override
  void dispose() {
    _stopTimer();
    releaseAudioRecorderResources();
    deleteFile();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.mediaRecorderStyle?.height ?? (Platform.isIOS? 160 : 130),
      width: widget.mediaRecorderStyle?.width,
      decoration: BoxDecoration(
        color: widget.mediaRecorderStyle?.gradient == null
            ? widget.mediaRecorderStyle?.background ??(_theme.palette.mode==PaletteThemeModes.light?   _theme.palette.getBackground() : Color.alphaBlend(_theme.palette.getAccent200(),
            _theme.palette.getBackground())) : null,
        gradient: widget.mediaRecorderStyle?.gradient,
        border: widget.mediaRecorderStyle?.border,
        borderRadius: BorderRadius.all(
            Radius.circular(widget.mediaRecorderStyle?.borderRadius ?? 8.0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 4.0, right:4),
            margin: const  EdgeInsets.all( 10.0),

            decoration: BoxDecoration(
              color:!_isRecording &&   _isAudioRecordingCompleted ?  _theme.palette.getAccent50() : Colors.transparent,
                borderRadius: _isAudioRecordingCompleted ? BorderRadius.circular(widget.mediaRecorderStyle?.borderRadius ?? 16.18) : BorderRadius.only(
                  topLeft: Radius.circular(widget.mediaRecorderStyle?.borderRadius ?? 8),
                  topRight: Radius.circular(widget.mediaRecorderStyle?.borderRadius ?? 8),)
                ,
                gradient: widget.mediaRecorderStyle?.gradient),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                   flex: 1,
                    child:
                 !_isRecording &&   _isAudioRecordingCompleted ?  getMediaButtons() : _isRecording? Text(
                        _formatElapsedTime(_elapsedTime), style: TextStyle(color: _theme.palette.getAccent(), fontSize:  _theme.typography.caption2.fontSize, fontWeight: _theme.typography.text2.fontWeight).merge(widget.mediaRecorderStyle?.timerTextStyle),
                      textAlign: TextAlign.center,
                    ):const SizedBox(),

                ),
const SizedBox(width: 10,),
                Flexible(
                    flex: 9,
                    child: SizedBox(
                      height: 60,
                      child:audioBar,
                    )),
                if (_isAudioRecordingCompleted)
                const SizedBox(width: 10,),
                if (_isAudioRecordingCompleted)
                  Text(
                    _formatElapsedTime(_elapsedTime), style: TextStyle(color: _theme.palette.getAccent(), fontSize: _theme.typography.caption2.fontSize, fontWeight: _theme.typography.text2.fontWeight).merge(widget.mediaRecorderStyle?.timerTextStyle),
                    textAlign: TextAlign.center,
                  )
              ]),
          ),
          Divider(height: 1, color: _theme.palette.getAccent50()),
          Container(
            height: 40,
            padding: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
                color: widget.mediaRecorderStyle?.gradient == null
                    ? widget.mediaRecorderStyle?.background
                    : null,
                gradient: widget.mediaRecorderStyle?.gradient,
                borderRadius: BorderRadius.only(
                    bottomLeft:
                    Radius.circular(widget.mediaRecorderStyle?.borderRadius ?? 8),
                    bottomRight:
                    Radius.circular(widget.mediaRecorderStyle?.borderRadius ?? 8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    constraints: const BoxConstraints(),
                    icon: widget.closeIcon ??
                        Image.asset(
                              AssetConstants.delete,
                          package: UIConstants.packageName,
                          color: widget.mediaRecorderStyle?.closeIconTint ??
                              _theme.palette.getAccent700(),
                        ),
                    onPressed: () async {
                     //exit media recorder
                      _stopTimer();
                      if (widget.onClose != null ) {
                        widget.onClose!();
                      } else{
                        pauseAudioPlayer();
                        deleteFile();
                        Navigator.pop(context);
                      }

                    }),
                //-----show add to chat bottom sheet-----
              // _isAudioRecordingCompleted ? const Spacer(): getRecordButtons(),
               getRecordButtons(),

                //-----show auxiliary buttons -----
    IconButton(
    padding: const EdgeInsets.all(0),
    constraints: const BoxConstraints(),
    icon: widget.submitIcon ??
    Image.asset(
    AssetConstants.send,
    package: UIConstants.packageName,
    color: _isAudioRecordingCompleted
    ?  widget.mediaRecorderStyle?.submitIconTint ??
    _theme.palette.getPrimary() : _theme.palette.getAccent400(),
    ),
    onPressed: () {
    if (_isAudioRecordingCompleted) {

    if (widget.onSubmit != null && path!=null && path!.isNotEmpty) {
    widget.onSubmit!(context,path!);
    }
    setState(() {
    path = null;
    });
    Navigator.pop(context);
    }
    },)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getStopButton(){
    return   IconButton(
        padding: const EdgeInsets.all(0),
        constraints: const BoxConstraints(),
        icon: widget.stopIcon ??
            Image.asset(
              AssetConstants.stopPlayer,
              package: UIConstants.packageName,
              color: widget.mediaRecorderStyle?.stopIconTint ??
                  _theme.palette.getError(),
              height: 24,
              width: 24,
            ),
        onPressed: stopRecording);
  }

  Widget getMediaButtons(){
    return _isPlaying ? getPauseButton() : getPlayButton();
  }

  Widget getRecordButtons(){
    return _isRecording ? _getStopButton() : _getStartButton();
  }

  Widget _getStartButton(){
    return 
        IconButton(
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints(),
            icon: widget.startIcon ??
                Image.asset(
                  AssetConstants.microphone,
                  package: UIConstants.packageName,
                  color: widget.mediaRecorderStyle?.startIconTint ??
                      _theme.palette.getSuccess(),
                  height: 24,
                  width: 24,
                ),
            onPressed: startRecording);
  }

  void startRecording() async {
    if(_isPlaying || _isRecording || path!=null || _isAudioRecordingCompleted ){
    try{
      UIConstants.channel.invokeMethod("releaseAudioRecorderResources");
    }catch (e){}
    }
    //start recording
    bool result = await  UIConstants.channel.invokeMethod("startRecordingAudio");
    if(result){
      _startTimer();
      setState(() {
        _isAudioRecordingCompleted = false;
        _isRecording = true;
        _isPlaying =false;
        audioBar =  AudioVisualizer(color:widget.mediaRecorderStyle?.audioBarTint ??  _theme.palette.getAccent700(), key: ValueKey(DateTime.now()),);
      });
    }

  }

  void stopRecording() async {
    //exit media recorder
    String? filePath =  await  UIConstants.channel.invokeMethod("stopRecordingAudio");
    _stopTimer();
    setState(() {
      _isRecording = false;
      _isAudioRecordingCompleted = true;
      path=filePath;
    });
  }

  void _startTimer() {
    _elapsedTime = Duration.zero;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedTime += const Duration(seconds: 1);
      if((_elapsedTime).inSeconds==1200){
        stopRecording();
      } else {
        setState(() {});
      }
    });
  }

  void _stopTimer(){
   try{
     if ( mounted &&  _timer.isActive){
       _timer.cancel();
     }
   } catch (e){
     if(kDebugMode){
       debugPrint("error in stopping timer $e");
     }
   }
  }

  Widget getPlayButton(){
return  IconButton(
    padding: const EdgeInsets.all(0),
    constraints: const BoxConstraints(),
    icon: widget.playIcon ??
        Image.asset(
          AssetConstants.play,
          package: UIConstants.packageName,
          color: widget.mediaRecorderStyle?.playIconTint ??
              _theme.palette.getPrimary(),
        ),
    onPressed: () async {
      //start playing recorded audio

      UIConstants.channel.invokeMethod("playRecordedAudio");
      setState(() {
        _isPlaying = true;
      });

    });
  }

  Widget getPauseButton(){
    return  IconButton(
        padding: const EdgeInsets.all(0),
        constraints: const BoxConstraints(),
        icon: widget.pauseIcon ??
            Image.asset(
              AssetConstants.pause,
              package: UIConstants.packageName,
              color: widget.mediaRecorderStyle?.pauseIconTint ??
                  _theme.palette.getPrimary(),
            ),
        onPressed: (){
          pauseAudioPlayer();

          if (mounted) {
            setState(() {
              _isPlaying = false;
            });
          }

        });
  }

  void pauseAudioPlayer()  {
    //pause playing recorded audio
    UIConstants.channel.invokeMethod("pausePlayingRecordedAudio");
  }

  void deleteFile(){
    try {
      if (path != null && path!.isNotEmpty) {
        UIConstants.channel.invokeMethod("deleteFile",{"filePath":path});
      }
    } catch (e){
        if(kDebugMode){
          debugPrint("error in deleting file $e");
        }
      }

  }

  ///[_formatElapsedTime] is used to format the elapsed time in the format of HH:MM:SS
  String _formatElapsedTime(Duration duration) {
    if (duration.inMinutes >= 1) {
      return '${(duration.inMinutes% 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      return '00:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

  void releaseAudioRecorderResources(){
    if(_isRecording || _isPlaying){
      try{
        UIConstants.channel.invokeMethod("releaseAudioRecorderResources");
      } catch (e){
        if(kDebugMode){
          debugPrint("error in releasing audio recorder resources $e");
        }
      }
    }
  }
}