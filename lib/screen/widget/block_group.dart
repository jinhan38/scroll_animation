import 'package:flutter/material.dart';
import 'package:scroll_animation/screen/widget/block.dart';

class BlockGroup extends StatelessWidget {
  double width;
  double height;
  double status;

  Size? size;

  BlockGroup({
    required this.width,
    required this.height,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size ??= MediaQuery.of(context).size;
    return SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            _blockBoxLeft(status, Block()),
            _blockBoxRight(status, Block()),
          ],
        ));
  }

  Widget _blockBoxLeft(double status, Widget widget) {
    double maxLeft = size!.width;
    double leftValue = 0;
    leftValue = maxLeft * status;
    return Positioned(
      left: leftValue - 100,
      top: 300,
      child: Opacity(opacity: 1, child: widget),
    );
  }

  Widget _blockBoxRight(double status, Widget widget) {
    double maxRight = size!.width + 200;
    double rightValue = 0;
    if (status < 0.5) {
      rightValue = maxRight * (status * 2);
    } else {
      rightValue = maxRight * ((1 - status) * 2);
    }
    return Positioned(
      right: rightValue - 100,
      top: 400,
      child: Opacity(opacity: 1, child: widget),
    );
  }
}
