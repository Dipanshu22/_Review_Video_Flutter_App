import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/video_provider.dart';

class CommentSection extends StatefulWidget {
  final String userRole;

  const CommentSection({Key? key, required this.userRole}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  String searchQuery = ''; // Current search query

  // Helper function to format timestamp
  String formatTimestamp(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = context.watch<VideoProvider>();
    final textController = TextEditingController();

    // Filtered comments based on search query
    final filteredComments = videoProvider.comments
        .where((comment) =>
            comment.content.toLowerCase().contains(searchQuery.toLowerCase()) ||
            comment.replies.any((reply) => reply.content
                .toLowerCase()
                .contains(searchQuery.toLowerCase())))
        .toList();

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value; // Update the search query
              });
            },
            decoration: InputDecoration(
              hintText: 'Search comments...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        // Scrollable list of filtered comments
        Expanded(
          child: ListView.builder(
            itemCount: filteredComments.length,
            itemBuilder: (context, index) {
              final comment = filteredComments[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Comment
                      ListTile(
                        title: Text('${comment.userRole}: ${comment.content}'),
                        subtitle:
                            Text('At ${formatTimestamp(comment.timestamp)}'),
                        trailing: widget.userRole == 'Artist'
                            ? IconButton(
                                icon: const Icon(Icons.reply),
                                onPressed: () {
                                  _showReplyDialog(
                                      context, videoProvider, index);
                                },
                              )
                            : null,
                      ),

                      // Replies Section
                      if (comment.replies.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: comment.replies.map((reply) {
                              return ListTile(
                                title:
                                    Text('${reply.userRole}: ${reply.content}'),
                                subtitle: Text(
                                    'At ${formatTimestamp(reply.timestamp)}'),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Input field for adding comments (Only Directors can add comments)
        if (widget.userRole == 'Director')
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      // Add the comment
                      videoProvider.addComment(
                          textController.text, widget.userRole);

                      // Clear the TextField and unfocus the keyboard
                      textController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Method to show a dialog for replying to comments (for Artists)
  void _showReplyDialog(
      BuildContext context, VideoProvider videoProvider, int index) {
    final replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reply to Comment'),
          content: TextField(
            controller: replyController,
            decoration: const InputDecoration(hintText: 'Enter your reply'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (replyController.text.isNotEmpty) {
                  videoProvider.addReply(index, replyController.text);

                  // Close the dialog and unfocus the keyboard
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                }
              },
              child: const Text('Reply'),
            ),
          ],
        );
      },
    );
  }
}
