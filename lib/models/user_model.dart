class UserModel {
  final String phoneNumber;
  final String password;
  final String name;
  final String experienceYears;
  final String address;
  final String level;

  const UserModel({
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.experienceYears,
    required this.address,
    required this.level,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phoneNumber: json['phoneNumber'],
        password: json['password'],
        name: json['name'],
        experienceYears: json['experienceYears'],
        address: json['address'],
        level: json['level'],
      );

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'password': password,
        'name': name,
        'experienceYears': experienceYears,
        'address': address,
        'level': level,
      };
}
