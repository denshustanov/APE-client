import 'package:flutter/material.dart';

class GuidingPage extends StatelessWidget{
  const GuidingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'Guiding',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
      );
  }
}