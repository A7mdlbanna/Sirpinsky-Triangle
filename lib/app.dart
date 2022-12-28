import 'package:flutter/material.dart';

class SirpinskyTriangle extends StatefulWidget {
  const SirpinskyTriangle({super.key});

  @override
  State<SirpinskyTriangle> createState() => _SirpinskyTriangleState();
}

class _SirpinskyTriangleState extends State<SirpinskyTriangle> {
  late Size size;

  /// the main three dots position
  Rect? mainPointA, mainPointB, mainPointC;

  List<Positioned> dots = [];

  int counter = 0;
  void addPoint(double dx, double dy) async{
    /// Wait a while to see the formation
    await Future.delayed(const Duration(microseconds: 1));

    /// create a new point
    Rect currPoint = Offset(dx, dy) & const Size(2, 2);
    setState(() {
      dots.add(Positioned.fromRect(rect: currPoint, child: const Point()));
    });

    /// select the main point
    Rect selectedMainPoint = ([mainPointA!, mainPointB!, mainPointC!]..shuffle()).first;

    /// get the next point coordinates
    print(size.width); print(size.height);
    print('MainPoint -> ${selectedMainPoint.left.toInt()}:${selectedMainPoint.top.toInt()}');
    print('currPoint -> ${currPoint.left.toInt()}:${currPoint.top.toInt()}');

    final nextDX = (selectedMainPoint.left + currPoint.left) / 2;
    final nextDY = (selectedMainPoint.top + currPoint.top) / 2;
    addPoint(nextDX, nextDY);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        size = context.size!;
        mainPointA = Offset(size.width / 2, size.height / 4) & const Size(10, 10);
        mainPointB = Offset(size.width / 10, size.height / (4 / 3)) & const Size(10, 10);
        mainPointC = Offset(size.width / (10 / 9), size.height / (4 / 3)) & const Size(10, 10);
      });
      addPoint(size.width / 2, (mainPointA!.top + mainPointC!.top) / 2);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sirpinsky Triangle',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(title: const Text('Sirpinsky Triangle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),),
        body: Stack(
          children: [
            if(mainPointA != null)Positioned.fromRect(rect: mainPointA!, child: const Point(mainPoint: true,)),
            if(mainPointB != null)Positioned.fromRect(rect: mainPointB!, child: const Point(mainPoint: true,)),
            if(mainPointC != null)Positioned.fromRect(rect: mainPointC!, child: const Point(mainPoint: true,)),
          ] + dots,
        ),
      ),
    );
  }
}

class Point extends StatelessWidget {
  const Point({Key? key, this.mainPoint = false}) : super(key: key);

  final bool mainPoint;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 5,
      backgroundColor: mainPoint ? Colors.deepOrange : Colors.black,

    );
  }
}
