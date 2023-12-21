import 'package:flutter/material.dart';

import 'app_bar_widget.dart';

Widget loadingView(
    bool loading,
    BuildContext context,
    WidgetBuilder content,
) {
  return loading ? const Scaffold(
      body: Center(child: CircularProgressIndicator())
  ) : content(context);
}