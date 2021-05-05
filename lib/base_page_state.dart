import 'package:flutter/material.dart';

import 'components/loading_view.dart';

abstract class BasePageState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  String locale = "en_US";
  bool _shownView = false;

  bool absorbing = false;
  bool showLoading = false;
  Widget loadingWidget = SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return !_shownView
        ? SizedBox.shrink()
        : FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return widgetCustomBuild(context)!;
          });
  }

  Widget? widgetCustomBuild(BuildContext context) {
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //_preRunFunction(context);
      setState(() {
        _shownView = true;
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangePlatformBrightness() {
  //   print("didChangePlatformBrightness");
  //   print(WidgetsBinding.instance.window.platformBrightness); // should print Brightness.light / Brightness.dark when you switch
  //   super.didChangePlatformBrightness(); // make sure you call this
  // }

  // Future<void> dataLoadBeforeWidgetLoad()async{
  //   locale = await UserRepo().getLocale();
  // }

  void showLoadingView(bool show) {
    setState(() {
      absorbing = show;
      showLoading = show;
      if (show) {
        loadingWidget = LoadingView(
          'Loading..',
          backgroundColor: Colors.black,
          textSize: 12,
        );
      } else {
        loadingWidget = SizedBox.shrink();
      }
    });
  }
}
