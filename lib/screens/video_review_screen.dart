import 'package:flutter/material.dart';
import '../widgets/video_player_widget.dart';
import '../widgets/comment_section.dart';

class VideoReviewScreen extends StatelessWidget {
  final String userRole;

  const VideoReviewScreen({Key? key, required this.userRole}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define gradients for each role
    final gradientColors = userRole == 'Director'
        ? [Colors.blueAccent, Colors.lightBlue]
        : [Colors.purpleAccent, Colors.deepPurple];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text('$userRole View'),
            backgroundColor: Colors.transparent, 
            elevation: 0,
          ),
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              // Landscape Mode: Video acquires full screen
              return VideoPlayerWidget(); // Fullscreen video player
            } else {
              // Portrait Mode: Original layout
              return Column(
                children: [
                  // Video Player at the top
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: VideoPlayerWidget(),
                  ),

                  // Comment Section and Input Box
                  Expanded(
                    child: CommentSection(userRole: userRole),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

