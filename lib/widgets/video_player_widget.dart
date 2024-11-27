import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import '../providers/video_provider.dart';
import './custom_seek_bar.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      context.read<VideoProvider>().setCurrentVideoTime(_controller.value.position);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = context.watch<VideoProvider>();

    return _controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              // Video Player
              LayoutBuilder(
                builder: (context, constraints) {
                  final videoWidth = constraints.maxWidth;
                  final videoHeight = videoWidth / _controller.value.aspectRatio;

                  return FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: videoWidth,
                      height: videoHeight,
                      child: VideoPlayer(_controller),
                    ),
                  );
                },
              ),

              // Play/Pause Overlay
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Container(
                  color: Colors.black26, // Slight overlay for visibility
                  child: Center(
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Custom Video Progress Indicator with Markers
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: CustomSeekBar(
                  controller: _controller,
                  commentTimestamps: videoProvider.comments
                      .map((comment) => comment.timestamp.inMilliseconds)
                      .toList(),
                ),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}

