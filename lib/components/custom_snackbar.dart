import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum MessageType {
  INFO,
  SUCCESS,
  ERROR,
  WARNING,
  DEFAULT,
}

class CustomSnackbar {
  static const int _defaultDuration = 3;
  double _defaultTextSize = 15.0;
  double _defaultIconSize = 28.0;
  EdgeInsets _defaultPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 20);

  static int getDuration() {
    return _defaultDuration;
  }

  void show(BuildContext context, message, MessageType type) {
    Color backgroundColor;
    Icon icon;

    switch (type) {
      case MessageType.ERROR:
        backgroundColor = Colors.red;
        icon = Icon(
          Icons.cancel,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;

      case MessageType.WARNING:
        backgroundColor = Colors.amberAccent[400]!;
        icon = Icon(
          Icons.warning,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;

      case MessageType.SUCCESS:
        backgroundColor = Colors.green;
        icon = Icon(
          Icons.check,
          size: _defaultIconSize,
          color: Colors.white,
        );
        break;
      default:
        backgroundColor = Color(0xFF303030);
        icon = Icon(
          Icons.info_outline,
          size: _defaultIconSize,
          color: Colors.white,
        );
    }

    _showFlushbar(context, message, bgColor: backgroundColor, icon: icon);
  }

  void _showFlushbar(BuildContext context, message,
      {bgColor, textSize, textColor, icon}) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: textSize != null ? textSize : _defaultTextSize,
          color: textColor != null ? textColor : Colors.white,
        ),
      ),
      padding: _defaultPadding,
      icon: icon,
      backgroundColor: bgColor != null ? bgColor : Color(0xFF303030),
      duration: Duration(seconds: _defaultDuration),
    )..show(context);
  }
}
