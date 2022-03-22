import 'package:flutter/material.dart';
import 'package:scroll_animation/screen/widget/block_group.dart';

class ScrollBoxScreen extends StatefulWidget {
  const ScrollBoxScreen({Key? key}) : super(key: key);

  @override
  _ScrollBoxScreenState createState() => _ScrollBoxScreenState();
}

class _ScrollBoxScreenState extends State<ScrollBoxScreen> {
  final int _totalPage = 20;
  ScrollController _controller = ScrollController();
  double scrollY = 0;
  Size? size;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        scrollY = _controller.offset;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size ??= MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _opacityBox_1(_calcStatusNormalize(500, 5000, scrollY),
                Text("푸드를 소개합니다", style: TextStyle(fontSize: 24))),
            _opacityBox_2(
                _calcStatusNormalize(1500, 4000, scrollY),
                Text(
                  "푸드홈 오픈",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                )),
            BlockGroup(
                width: size!.width,
                height: size!.height,
                status: _calcStatusNormalize(1000, size!.height * _totalPage - 800, scrollY)),
            Scrollbar(
              isAlwaysShown: true,
              thickness: 10,
              radius: const Radius.circular(5),
              scrollbarOrientation: ScrollbarOrientation.right,
              child: SingleChildScrollView(
                controller: _controller,
                child: _parentBox(size!.width, size!.height),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _parentBox(double width, double height) {
    return SizedBox(
      width: width,
      height: height * _totalPage,
    );
  }

  Widget _opacityBox_1(
    double status,
    Widget widget,
  ) {
    double maxLeft = size!.width + 300;
    double maxTop = size!.height;
    double leftValue = 0;
    double topValue = 0;
    if (status < 0.5) {
      leftValue = maxLeft * status;
      topValue = maxTop * status;
    } else {
      leftValue = maxLeft * (1 - status);
      topValue = maxTop * status;
    }
    return Positioned(
      left: leftValue,
      top: topValue,
      child: Opacity(opacity: status, child: widget),
    );
  }

  Widget _opacityBox_2(
    double status,
    Widget widget,
  ) {
    double maxTop = 300;
    double topValue = 0;
    double opacity = 0;
    if (status < 0.5) {
      topValue = maxTop * status;
      opacity = status;
    } else {
      topValue = maxTop * (1 - status);
      opacity = 1 - status;
    }
    return Positioned(
      top: topValue,
      child: Opacity(opacity: opacity, child: widget),
    );
  }

  double _calcStatusNormalize(double minY, double maxY, double currentY) {
    if (currentY > minY && currentY < maxY) {
      double temp = maxY - minY;
      double value = maxY - currentY;
      double result = 1 - value / temp;
      if (result > 1) {
        result = 1;
      }
      return result;
    }
    return 0;
  }
}
