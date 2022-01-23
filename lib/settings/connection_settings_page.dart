import 'package:astro_photo_environment/service_locator.dart';
import 'package:astro_photo_environment/services/http_service.dart';
import 'package:flutter/material.dart';

class ConnectionSettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ConnectionSettingsPageState();

}

class _ConnectionSettingsPageState extends State<ConnectionSettingsPage>{
  final HttpService _httpService = getIt<HttpService>();

  TextEditingController _hostController = TextEditingController();
  TextEditingController _portController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    _hostController.text = _httpService.getModuleUrl();
    _portController.text = _httpService.getModulePort().toString();
    _loginController.text = _httpService.getLogin();
    _passwordController.text = _httpService.getPassword();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('host'),
                  Container(
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.url,
                      controller: _hostController,
                      onSubmitted: (value){
                        setState(() {
                          _httpService.setModuleUrl(value);
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('port'),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _portController,
                      onSubmitted: (value){
                        setState(() {
                          _httpService.setModulePort(int.parse(value));
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('username'),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _loginController,
                      onSubmitted: (value){
                        setState(() {
                          _httpService.setLogin(value);
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('password'),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: _passwordController,
                      onSubmitted: (value){
                        setState(() {
                          _httpService.setPassword(value);
                        });
                      },
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: (){},
                child: const Text('Test connection'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}