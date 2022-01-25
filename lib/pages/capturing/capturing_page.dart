import 'package:astro_photo_environment/services/http_service.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class CapturingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CapturingPageState();
}

class _CapturingPageState extends State<CapturingPage> {
  final HttpService _httpService = getIt<HttpService>();

  //image
  final String _imagePlaceholderPath = 'assets/images/image_placeholder.png';
  bool _noImage = true;
  String _imageURL = '';
  String _imageType = 'test';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_imageSection(), _toolsSection()],
      ),
    );
  }

  Widget _imageSection() {
    return (_noImage)
        ? Image.asset(_imagePlaceholderPath)
        : Image.network(_imageURL);
  }

  Widget _toolsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: _captureImage, icon: const Icon(Icons.camera), tooltip: 'Capture image',),
        IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow), tooltip: 'Start sequence',),
        IconButton(onPressed: () {}, icon: const Icon(Icons.stop), tooltip: 'Stop sequence',),
        IconButton(onPressed: (){Navigator.pushNamed(context, '/capturing/settings');}, icon: const Icon(Icons.camera_enhance))
      ],
    );
  }

  void _captureImage() async{
    String imagePath = await _httpService.capture(_imageType);
    setState(() {
      _imageURL = _httpService.getImageURL(imagePath);
      _noImage = false;
    });
  }
}
