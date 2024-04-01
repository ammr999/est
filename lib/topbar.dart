import 'dart:async';
import 'constants.dart';
import 'package:flutter/material.dart';

List<String> boardArray1 = ['400 +', '330 +', '900 +'];
List<String> boardArray2 = ['أكاديمية', 'مركز لياقة بدنية', 'شركة خدمات رياضية'];
List<String> boardArray3 = ['2000 +', '20 +', '13000 +'];
List<String> boardArray4 = ['ملعب مفتوح', 'مجمع رياضي', 'موقع رياضي'];
List<String> boardArray5 = ['7 ', '40 +', '2000 +'];
List<String> boardArray6 = ['أندية بدبي', 'أندية خاصة', 'موهبة رياضية'];

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index1 = 0, index2 = 0, index3 = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        if (index1 < boardArray1.length - 1) index1++;
        else index1 = 0;
      });
    });

    Timer.periodic(Duration(seconds: 7), (timer) {
      setState(() {
        if (index2 < boardArray2.length - 1) index2++;
        else index2 = 0;
      });
    });

    Timer.periodic(Duration(seconds: 9), (timer) {
      setState(() {
        if (index3 < boardArray3.length - 1) index3++;
        else index3 = 0;
      });
    });
  }

@override
Widget build(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 1 / 5,
    child: Row(
      children: [
        Expanded(
          child: Card(
            color: boardColors[0],
            child: Column(
              children: [
                Container(height: 20), 
                BoardWidget(boardArray1[index1], boardColors[0], boardTextStyles[0], showBackground: false),
                Container(height: 20), 
                BoardWidget(boardArray2[index1], boardColors[0], boardTextStyles[0], showBackground: false),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            color: boardColors[0],
            child: Column(
              children: [
                Container(height: 20), 
                BoardWidget(boardArray3[index2], boardColors[0], boardTextStyles[0], showBackground: false),
                Container(height: 20),
                BoardWidget(boardArray4[index2], boardColors[0], boardTextStyles[0], showBackground: false),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            color: boardColors[0],
            child: Column(
              children: [
                Container(height: 20), 
                BoardWidget(boardArray5[index3], boardColors[0], boardTextStyles[0], showBackground: false),
                Container(height: 20),
                BoardWidget(boardArray6[index3], boardColors[0], boardTextStyles[0], showBackground: false),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}

class BoardWidget extends StatefulWidget {
  final String text;
  final Color color;
  final TextStyle textStyle;
  final bool showBackground;

  BoardWidget(this.text, this.color, this.textStyle, {this.showBackground = true});

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}


class _BoardWidgetState extends State<BoardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  String? _previousText;

  @override
  void initState() {
    super.initState();

    _previousText = widget.text;  // Store the initial text

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),  // Adjust the duration as needed
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Once the animation completes, set the previous text to the current one
          _previousText = widget.text;
          _controller.reset();
        }
      });
  }

  @override
  void didUpdateWidget(BoardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.showBackground
        ? Card(
            color: widget.color,
            child: buildTextContent(),
          )
        : buildTextContent();
  }

  Widget buildTextContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Current text (fading out)
        Opacity(
          opacity: 1 - _fadeAnimation.value,
          child: Center(child: Text(_previousText!, style: widget.textStyle)),
        ),
        // New text (fading in)
        Opacity(
          opacity: _fadeAnimation.value,
          child: Center(child: Text(widget.text, style: widget.textStyle)),
        ),
      ],
    );
  }
}

