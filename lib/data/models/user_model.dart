class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String photo;

  String get fullName {
    return '$firstName $lastName';
  }

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['_id'],
      email: jsonData['email'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      mobile: jsonData['mobile'],
      photo: jsonData['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
    };
  }
}

//
//Body: {"status":"success","data":
// {"_id":"68d1408ab4f34e7d4b4293f4","email":"abdulkhalekt10@gmail.com",
// "firstName":"Abdul","lastName":"Khalek","mobile":"01404056533","createdDate":"2025-07-16T06:07:55.534Z"},
// "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTg2MzQwNjksImRhdGEiOiJhYmR1bGtoYWxla3QxMEBnbWFpbC5jb20iLCJpYXQiOjE3NTg1NDc2Njl9.lUh6SnzCzZHta-JeIFnAaTTlRbIUOslmRqZJn9D436E"}