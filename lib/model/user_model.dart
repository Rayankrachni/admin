

class UserModel{
  String id;
  String firstname;
  String lastname;
  String email;
  String phone;
  String deviceToken;
  String amount;

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.deviceToken,
    required this.lastname,
    required this.phone,
    required this.amount});


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'].toString(),
    firstname: json['firstname'].toString(),
    lastname: json['lastname'].toString(),
    email: json['email'].toString(),
    phone: json['phone'].toString(),
    amount: json['amount'].toString(),
    deviceToken:json['deviceToken'].toString(),


  );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'deviceToken': deviceToken,
      'amount': amount,
    };
  }


}