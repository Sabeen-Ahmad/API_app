class Postsmodel {
  late final num _userId;  // Declare instance variables with the `late` keyword
  late final num _id;
  late final String _title;
  late final String _body;

  // Constructor with required parameters
  Postsmodel({
    required num userId,
    required num id,
    required String title,
    required String body,
  }) {
    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
  }

  // Named constructor for creating an instance from JSON data
  Postsmodel.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
  }

  // Copy method to create a new instance with optional modified values
  Postsmodel copyWith({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) {
    return Postsmodel(
      userId: userId ?? _userId,
      id: id ?? _id,
      title: title ?? _title,
      body: body ?? _body,
    );
  }

  // Getters
  num get userId => _userId;
  num get id => _id;
  String get title => _title;
  String get body => _body;

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }
}
