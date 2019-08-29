import 'package:flutter/material.dart';
import 'package:Amnesia/util/constants.dart';

class ProgressWidget extends StatelessWidget {
  final Widget child;
  final ValueChanged<bool> progressListener;
  final bool isLoading;

  ProgressWidget(
      {this.progressListener, @required this.isLoading, @required this.child});

  Widget getBlockingUi(BuildContext context) {
    return FractionallySizedBox(
      child: GestureDetector(
          child: Container(
        color: Colors.black.withAlpha(70),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackWidgets = [];
    stackWidgets.add(child);
    if (isLoading) {
      stackWidgets.add(getBlockingUi(context));
      stackWidgets.add(progressBar(context));
    }

    return Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: stackWidgets);
  }

  Widget buildProgressBarContainer(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 10,
      backgroundColor: Colors.yellow,
      valueColor: new AlwaysStoppedAnimation<Color>(Constants.COLORMAIN),
    );
  }

  Widget progressBar(BuildContext context) {
    return Positioned(
      width: 60,
      height: 60,
      child: buildProgressBarContainer(context),
    );
  }
}
