class UserModel {
  late String? id;
  late String? fullname;
  late String? email;
  late String? branch;

  UserModel({
    this.id,
    this.fullname,
    this.branch,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': fullname,
      'email': email,
      'branch': branch,
    };
  }
}
