import 'package:code_magic_test/home/view/details.dart';
import 'package:code_magic_test/home/widgets/post_list_item.dart';
import 'package:code_magic_test/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('end-to-end test', () {
    testWidgets('View Post Testing', (WidgetTester tester) async {
      // Run app
      app.main();
      await tester.pumpAndSettle();

      // Expect to find a list of posts
      expect(find.byType(PostListItem), findsWidgets);

      // Tap on first post
      await tester.tap(find.byType(PostListItem).first);
      await tester.pumpAndSettle();

      // Expect to find details page
      expect(find.byType(DetailedPage), findsOneWidget);
    });
  });
}
