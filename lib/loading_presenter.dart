import 'package:dudv_base/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config.dart';

mixin LoadingPresenter {
  bool _isShowDialog = false;

  static Color? _color;

  static void color(Color color) {
    _color = color;
  }

  BuildContext get context;

  void showLoading({bool useRootNavigator = false}) {
    _isShowDialog = true;
    Utils.showModalDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      bg: DudvConfig.bgLoadingValue,
      view: SizedBox(
          width: 100,
          height: 100,
          child: Center(
              child: DudvConfig.loadingView ??
                  (Utils.isAndroid
                      ? CircularProgressIndicator(
                        color: _color,
                      )
                      : CupertinoActivityIndicator(
                          radius: 15,
                          color: _color,
                        )))),
    );
  }

  Future hideLoading() async {
    if (!_isShowDialog) return;
    return Future.delayed(const Duration(milliseconds: 300), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      _isShowDialog = false;
    });
  }
}
