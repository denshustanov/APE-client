import 'package:astro_photo_environment/capturing/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SessionDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SessionDetailsPageState();

}

class _SessionDetailsPageState extends State<SessionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Session;

    return Stack(
      children: [
      Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: const Icon(Icons.add), color:
        Colors.white,
          onPressed: () {},
        ),
      ),
    ),
    ]
    );
  }

}