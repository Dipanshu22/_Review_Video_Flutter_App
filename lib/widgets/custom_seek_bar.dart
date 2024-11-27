import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomSeekBar extends StatelessWidget {
  final VideoPlayerController controller;
  final List<int>
      commentTimestamps; // List of comment timestamps 

  const CustomSeekBar({
    Key? key,
    required this.controller,
    required this.commentTimestamps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalDuration = controller.value.duration.inMilliseconds;
        final barWidth = constraints.maxWidth;

        // Calculate marker positions as fractions of the progress bar width
        final markerPositions = commentTimestamps
            .where((timestamp) => timestamp <= totalDuration)
            .map((timestamp) => (timestamp / totalDuration) * barWidth)
            .toList();

        return Stack(
          alignment: Alignment.center,
          children: [
            // Main Video Progress Indicator
            VideoProgressIndicator(
              controller,
              allowScrubbing: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),

            // Markers for comment timestamps
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: markerPositions.map((position) {
                  return Transform.translate(
                    offset: Offset(position, 0),
                    child: GestureDetector(
                      onTap: () {
                        controller.seekTo(
                          Duration(
                              milliseconds: commentTimestamps[
                                  markerPositions.indexOf(position)]),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800], 
                          borderRadius:
                              BorderRadius.circular(8), 
                        ),
                        padding: const EdgeInsets.all(
                            2), 
                        child: Container(
                          width: 4,
                          height: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
