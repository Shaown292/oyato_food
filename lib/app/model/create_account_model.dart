class CreateUserModel {
  String? createUser;
  String? email;
  String? password;
  String? fullname;
  String? gettoken;

  CreateUserModel(
      {this.createUser,
        this.email,
        this.password,
        this.fullname,
        this.gettoken});

  CreateUserModel.fromJson(Map<String, dynamic> json) {
    createUser = json['create-user'];
    email = json['email'];
    password = json['password'];
    fullname = json['fullname'];
    gettoken = json['gettoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['create-user'] = createUser;
    data['email'] = email;
    data['password'] = password;
    data['fullname'] = fullname;
    data['gettoken'] = gettoken;
    return data;
  }
}
