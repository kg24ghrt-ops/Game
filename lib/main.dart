import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// A component is Flame's unit of "thing in the world". This one paints itself
/// and moves every tick; [update] is called with the delta time in seconds so
/// movement stays frame-rate independent.
class Ball extends PositionComponent {
  Ball() : super(size: Vector2.all(48), anchor: Anchor.center);

  Vector2 velocity = Vector2(120, 90);
  final Paint _paint = Paint()..color = Colors.amber;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    // Bounce off the edges of the game surface.
    final bounds = findGame()!.size;
    if (position.x <= 0 || position.x >= bounds.x) velocity.x = -velocity.x;
    if (position.y <= 0 || position.y >= bounds.y) velocity.y = -velocity.y;
  }

  @override
  void render(Canvas canvas) => canvas.drawCircle(Offset(width / 2, height / 2), width / 2, _paint);
}

class MyGame extends FlameGame with TapCallbacks {
  int taps = 0;

  late final Ball ball;

  @override
  Future<void> onLoad() async {
    ball = Ball()..position = size / 2;
    add(ball);
  }

  @override
  void onTapDown(TapDownEvent event) {
    taps++;
    // Reverse direction on tap so input is visibly wired up.
    ball.velocity = -ball.velocity;
  }
}

void main() => runApp(GameWidget(game: MyGame()));
