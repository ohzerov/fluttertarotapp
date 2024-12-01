import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarot/core/utils/size_config.dart';
import 'package:tarot/features/home_screen/presentation/pages/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
