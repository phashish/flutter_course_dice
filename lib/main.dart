import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // leading: const Icon(Icons.menu),
          title: const Text('Roll a Dice'),
          centerTitle: true,
        ),
        body: const DiceWidget(),
      ),
    );
  }
}

class DiceWidget extends StatefulWidget {
  const DiceWidget({super.key});

  @override
  State<DiceWidget> createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  int number = 1;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    setState(() {
      number = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter: DicePainter(number: number),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  number = 1 + _random.nextInt(6);
                  // print(number);
                });
              },
              child: const Text('Roll Dice!')),
        ],
      ),
    );
  }
}

// Create a class to return a painted dice with given number
class DicePainter extends CustomPainter {
  final int number;

  DicePainter({required this.number});

  // Define relative dot positions

  @override
  void paint(Canvas canvas, Size size) {
    Map<int, List<Offset>> dotPositions = {
      1: [
        Offset(size.width * 0.50, size.height * 0.50),
      ], // Center
      2: [
        Offset(size.width * 0.25, size.height * 0.25),
        Offset(size.width * 0.75, size.height * 0.75),
      ], // Diagonals
      3: [
        Offset(size.width * 0.50, size.height * 0.50),
        Offset(size.width * 0.25, size.height * 0.25),
        Offset(size.width * 0.75, size.height * 0.75),
      ], // Center and Diagonals
      4: [
        Offset(size.width * 0.25, size.height * 0.25),
        Offset(size.width * 0.75, size.height * 0.75),
        Offset(size.width * 0.75, size.height * 0.25),
        Offset(size.width * 0.25, size.height * 0.75)
      ], // Corners
      5: [
        Offset(size.width * 0.50, size.height * 0.50),
        Offset(size.width * 0.25, size.height * 0.25),
        Offset(size.width * 0.75, size.height * 0.75),
        Offset(size.width * 0.75, size.height * 0.25),
        Offset(size.width * 0.25, size.height * 0.75)
      ], // Corners + Center
      6: [
        Offset(size.width * 0.25, size.height * 0.25),
        Offset(size.width * 0.75, size.height * 0.75),
        Offset(size.width * 0.75, size.height * 0.25),
        Offset(size.width * 0.25, size.height * 0.75),
        Offset(size.width * 0.75, size.height * 0.50),
        Offset(size.width * 0.25, size.height * 0.50)
      ], // Corners + Center Lines
    };
    // Draw Dice Background
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    final rect = Rect.fromCenter(
      center: Offset(size.width * 0.50, size.height * 0.50),
      width: size.width * 0.80,
      height: size.height * 0.80,
    );
    canvas.drawRect(rect, paint);

    // Draw Dice Dots
    paint.color = Colors.blue;
    _drawDots(canvas, dotPositions[number] ?? [], paint, size);
  }

  // Draw dots based on given positions
  void _drawDots(
      Canvas canvas, List<Offset> positions, Paint paint, Size size) {
    for (var position in positions) {
      double dotSize = size.width * 0.06;
      canvas.drawCircle(position, dotSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DicePainter oldDelegate) {
    return oldDelegate.number != number;
  }
}
