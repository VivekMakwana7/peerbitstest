class user {
  String? id;
  String? first_name;
  String? last_name;
  String? full_name;
  String? email;
  String? phone_no;
  String? image;

  user({
    this.id,
    this.first_name,
    this.last_name,
    this.full_name,
    this.email,
    this.phone_no,
    this.image,
  });

  factory user.fromJson(Map<String, dynamic> jsonData) {
    return user(
      id: jsonData['id'],
      first_name: jsonData['first_name'],
      last_name: jsonData['last_name'],
      full_name: jsonData['full_name'],
      email: jsonData['email'],
      phone_no: jsonData['phone_no'],
      image: jsonData['image'],
    );
  }
}
