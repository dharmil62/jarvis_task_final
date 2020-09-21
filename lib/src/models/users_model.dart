class UsersModel {
  int _page;
  int _per_page;
  int total;
  int _total_pages;
  List<_Result> _data = [];
  int id;
  String email;
  String first_name;
  String last_name;
  String avatar;

  UsersModel.fromJson(Map<String, dynamic> parsedJson, {email}) {
    print(parsedJson['data'].length);
    _page = parsedJson['page'];
    _per_page = parsedJson['per_page'];
    _total_pages = parsedJson['total_pages'];
    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      _Result result = _Result(parsedJson['data'][i]);
      temp.add(result);
    }
    _data = temp;
  }

  List<_Result> get data => _data;

  int get total_pages => _total_pages;

  int get total_results => _per_page;

  int get page => _page;

  UsersModel({this.id, this.email, this.first_name, this.last_name, this.avatar});

 factory UsersModel.fromMap(Map<String, dynamic> json) => new UsersModel(
   id: json["id"],
   email: json["email"],
   first_name: json["first_name"],
   last_name: json["last_name"],
   avatar: json["avatar"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
  "email": email,
  "first_name": first_name,
  "last_name": last_name,
  "avatar": avatar,
  };

  


}

class _Result {
  int _id;
  String _email;
  String _first_name;
  String _last_name;
  String _avatar;


  _Result(result) {
    _id = result['id'];
    _email = result['email'];
    _first_name = result['first_name'];
    _last_name = result['last_name'];
    _avatar = result['avatar'];
  }

  String get avatar  => _avatar;

  String get last_name => _last_name;

  String get first_name => _first_name;

  String get email => _email;

  int get id => _id;

}