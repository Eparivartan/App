import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Vedio extends StatefulWidget {
  final int index;
  final String videoName;
  final String videoDuration;
  final String videoEmbedUrl;

  Vedio({
    required this.index,
    required this.videoName,
    required this.videoDuration,
    required this.videoEmbedUrl,
  });

  @override
  _VedioState createState() => _VedioState();
}

class _VedioState extends State<Vedio> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoEmbedUrl)
      ..initialize().then((_) {
        setState(() {});  // Ensure the first frame is shown after the video is initialized.
        _controller.play();  // Auto-play the video.
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoName),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
