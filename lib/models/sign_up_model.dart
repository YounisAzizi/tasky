import 'package:Tasky/models/level_enum.dart';

const defaultSignUp = SignUpModel(
  phone: '',
  password: '',
  displayName: '',
  experienceYears: null,
  address: '',
  level: LevelEnum.junior,
);

class SignUpModel {
  final String phone;
  final String password;
  final String displayName;
  final int? experienceYears;
  final String address;
  final LevelEnum level;

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
        level: LevelEnum.fromString(json['level']),
      );

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'password': password,
        'displayName': displayName,
        'experienceYears': experienceYears,
        'address': address,
        'level': level.name,
      };

  SignUpModel copyWith({
    String? phone,
    String? password,
    String? displayName,
    int? experienceYears,
    String? address,
    LevelEnum? level,
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
