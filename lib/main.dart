import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing Pad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(body: DragArea()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DragArea extends StatefulWidget {
  const DragArea({super.key});

  @override
  State<DragArea> createState() => _DragAreaState();
}

class _DragAreaState extends State<DragArea> {
  Offset pos = Offset(50, 80);
  double scale = 1.0;
  double startScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          setState(() {
            scale += event.scrollDelta.dy * -0.001;
            scale = scale.clamp(0.5, 3.0);
          });
        }
      },
      child: GestureDetector(
        // onPanUpdate: (details) {
        //   setState(() {
        //     pos += details.delta;
        //   });
        // },
        onScaleStart: (details) {
          startScale = scale;
        },
        onScaleUpdate: (details) {
          setState(() {
            scale = (startScale * details.scale).clamp(0.5, 3.0);
            pos += details.focalPointDelta;
          });
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                // width: MediaQuery.of(context).size.width + 100,
                // height: MediaQuery.of(context).size.height + 40,
              ),
              Positioned(
                top: pos.dy,
                left: pos.dx,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "${pos.dx.toInt()}, ${pos.dy.toInt()}\nScale: ${scale.toStringAsFixed(2)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
