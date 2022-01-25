import 'package:astro_photo_environment/capturing/image_service.dart';
import 'package:astro_photo_environment/capturing/session.dart';
import 'package:astro_photo_environment/service_locator.dart';
import 'package:flutter/material.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  final ImageService _imageService = getIt<ImageService>();
  List<Session> _sessions = [];

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      RefreshIndicator(
        onRefresh: updateSessions,
        color: Colors.redAccent,
        child: ListView.builder(
            itemCount: _sessions.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                title: Text(_sessions.elementAt(index).name),
                // onTap: (){Navigator.pushNamed(context, '/sessions/detail/', arguments: _sessions.elementAt(index));},
              ));
            }),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
    ]);
  }

  Future<void> updateSessions() async {
    List<Session> sessions = await _imageService.update();
    setState(() {
      _sessions = sessions;
    });
  }
}
