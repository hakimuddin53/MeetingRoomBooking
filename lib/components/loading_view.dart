import 'package:abx_booking/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  final double opacity;
  final Color backgroundColor;
  final Color iconColors;
  final String displayText;
  final Color textColor;
  final double textSize;

  LoadingView(this.displayText,
      {Key? key,
      this.opacity = 0.7,
      this.backgroundColor = Colors.white,
      this.iconColors = Colors.orange,
      this.textColor = Colors.orange,
      this.textSize = FontSizeConstant.Large})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: opacity,
            child: Container(
              color: backgroundColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitDoubleBounce(color: iconColors),
              SizedBox(
                height: 20,
              ),
              Text(
                displayText,
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
