class Session{
  String _name;
  late final List<String> _tests;
  late final List<String> _lights;
  late final List<String> _darks;
  late final List<String> _flats;
  late final List<String> _biases;

  Session.withImages(this._name, this._tests, this._lights, this._darks, this._flats, this._biases);


  Session(this._name){
    _tests = [];
    _lights = [];
    _darks = [];
    _flats = [];
    _biases = [];
  }

  String get name => _name;

  void addTestImage(String imagePath){
    _tests.add(imagePath);
  }

  void addLightImage(String imagePath){
    _lights.add(imagePath);
  }

  void addDarkImage(String imagePath){
    _darks.add(imagePath);
  }

  void addFlatImage(String imagePath){
    _flats.add(imagePath);
  }

  void addBiasImage(String imagePath){
    _biases.add(imagePath);
  }

  List<String> get biases => _biases;

  List<String> get flats => _flats;

  List<String> get darks => _darks;

  List<String> get lights => _lights;

  List<String> get tests => _tests;

  factory Session.fromJson(Map<String, dynamic> json){
    return Session.withImages(json['name'],
        json['images']['tests'].cast<String>(),
        json['images']['lights'].cast<String>(),
        json['images']['darks'].cast<String>(),
        json['images']['flats'].cast<String>(),
        json['images']['biases'].cast<String>()
    );
  }
}