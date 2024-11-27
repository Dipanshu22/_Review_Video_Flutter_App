import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:review_video_app/widgets/video_player_widget.dart';

import 'package:review_video_app/app.dart';

void main() {
  testWidgets('Role selection and navigation smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the role selection buttons are displayed.
    expect(find.text('I am a Director'), findsOneWidget);
    expect(find.text('I am an Artist'), findsOneWidget);

    // Tap the 'I am a Director' button and trigger navigation.
    await tester.tap(find.text('I am a Director'));
    await tester.pumpAndSettle(); // Wait for navigation animation to complete.

    // Verify that the VideoReviewScreen is displayed for the Director.
    expect(find.text('Director View'), findsOneWidget);

    // Verify the video player and comment input field are visible.
    expect(find.byType(VideoPlayerWidget), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Add a comment as a Director.
    await tester.enterText(find.byType(TextField), 'This is a test comment.');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Verify the comment is added.
    expect(find.text('Director: This is a test comment.'), findsOneWidget);

    // Return to role selection screen.
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Verify the role selection buttons are displayed again.
    expect(find.text('I am a Director'), findsOneWidget);
    expect(find.text('I am an Artist'), findsOneWidget);

    // Tap the 'I am an Artist' button and trigger navigation.
    await tester.tap(find.text('I am an Artist'));
    await tester.pumpAndSettle(); // Wait for navigation animation to complete.

    // Verify that the VideoReviewScreen is displayed for the Artist.
    expect(find.text('Artist View'), findsOneWidget);

    // Verify the video player and comment section are visible.
    expect(find.byType(VideoPlayerWidget), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}

