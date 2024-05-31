const defaultSignUp = SignUpModel(
  phone: '',
  password: '',
  displayName: '',
  experienceYears: '',
  address: '',
  level: '',
);

class SignUpModel {
  final String phone;
  final String password;
  final String displayName;
  final String experienceYears;
  final String address;
  final String level;

  const SignUpModel({
    required this.phone,
    required this.password,
    required this.displayName,
    required this.experienceYears,
    required this.address,
    required this.level,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        phone: json['phone'],
        password: json['password'],
        displayName: json['displayName'],
        experienceYears: json['experienceYears'],
        address: json['address'],
        level: json['level'],
      );

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
        'displayName': displayName,
        'experienceYears': experienceYears,
        'address': address,
        'level': level,
      };

  SignUpModel copyWith({
    String? phone,
    String? password,
    String? displayName,
    String? experienceYears,
    String? address,
    String? level,
  }) {
    return SignUpModel(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
      experienceYears: experienceYears ?? this.experienceYears,
      address: address ?? this.address,
      level: level ?? this.level,
    );
  }

  bool isEqual(SignUpModel other) {
    return other.phone == phone &&
        other.password == password &&
        other.displayName == displayName &&
        other.experienceYears == experienceYears &&
        other.address == address &&
        other.level == level;
  }
}
