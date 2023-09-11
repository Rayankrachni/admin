

class UserModel{
  String id;
  String firstname;
  String phone;
  String deviceToken;
  String amount;
  String country;

  UserModel({
    required this.id,
    required this.firstname,
    required this.deviceToken,
    required this.phone,
    required this.country,
    required this.amount});


  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'].toString(),
    firstname: json['firstname'].toString(),
    phone: json['phone'].toString(),
    amount: json['amount'].toString(),
    country: json['country'].toString(),
    deviceToken:json['deviceToken'].toString(),


  );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'phone': phone,
      'deviceToken': deviceToken,
      'amount': amount,
      'country': country,
    };
  }


}