class UserModel {
  final String phoneNumber;
  final String password;
  final String name;
  final String experienceYears;
  final String address;
  final String level;

  UserModel({
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.experienceYears,
    required this.address,
    required this.level,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      name: json['name'],
      experienceYears: json['experienceYears'],
      address: json['address'],
      level: json['level'],
    );
  }

  // Method to convert a UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'experienceYears': experienceYears,
      'address': address,
      'level': level,
    };
  }
}
