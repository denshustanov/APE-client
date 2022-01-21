import 'package:flutter/material.dart';
import 'dart:io';

class PhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  //camera info
  String _cameraModel = '';
  String _cameraManufacturer = '';
  int _cameraShutterCounter = 0;

  bool _cameraConnected = false;

  //camera settings
  String _iso = '';
  List<DropdownMenuItem<String>> _isoChoices = [];

  String _shutterSpeed = '';
  List<DropdownMenuItem<String>> _shutterSpeedChoices = [];

  String _imageFormat = '';
  List<DropdownMenuItem<String>> _imageFormatChoices = [];

  //sequence settins
  int _sequenceLength = 10;
  TextEditingController _sequenceLengthController = TextEditingController(
    text: '10'
  );

  //image
  final String _imagePlaceholderPath = 'assets/images/image_placeholder.png';
  bool _noImage = true;
  String _imagePath = '';

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
        : Image.file(File(_imagePath));
  }

  Widget _toolsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.camera), tooltip: 'Capture image',),
        IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow), tooltip: 'Start sequence',),
        IconButton(onPressed: () {}, icon: const Icon(Icons.stop), tooltip: 'Stop sequence',),
        IconButton(onPressed: _showCapturingSettingsDialog, icon: const Icon(Icons.settings))
      ],
    );
  }

  _showCapturingSettingsDialog() {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text((_cameraConnected)? _cameraModel : 'No camera conected!'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Shutter Speed'),
                        DropdownButton(items: _isoChoices, onChanged: (value){})
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ISO'),
                        DropdownButton(items: _shutterSpeedChoices, onChanged: (value){})
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Image Format'),
                        DropdownButton(items: _imageFormatChoices, onChanged: (value){})
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sequence Size'),
                        Row(
                          children: [
                            IconButton(onPressed: (){
                              setState(() {
                                if(_sequenceLength > 1) {
                                  _sequenceLength -= 1;
                                  _sequenceLengthController.text = _sequenceLength.toString();
                                }
                              });
                            }, icon: const Icon(Icons.remove)),
                            Container(
                              width: 50,
                              child: TextField(
                                controller: _sequenceLengthController,
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  setState(() {
                                    int length = int.parse(value);
                                    if(length<1000 && length> 0) {
                                      _sequenceLength = int.parse(value);
                                    } else{
                                      _sequenceLengthController.text = _sequenceLength.toString();
                                    }
                                  });
                                }),
                            ),
                            IconButton(onPressed: (){
                              setState(() {
                                _sequenceLength += 1;
                                _sequenceLengthController.text = _sequenceLength.toString();
                              });
                            }, icon: const Icon(Icons.add)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
    );
  }
}
