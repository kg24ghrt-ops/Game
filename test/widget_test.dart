import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('the game loads its ball component and steps the world', (tester) async {
    final game = MyGame();
    await tester.pumpWidget(GameWidget(game: game));

    // One frame to let onLoad run and the component tree attach.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));

    expect(game.children.whereType<Ball>().length, 1);

    final start = game.ball.position.clone();
    game.update(0.5);
    expect(game.ball.position, isNot(equals(start)));
  });
}
