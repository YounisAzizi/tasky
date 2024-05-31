enum LevelEnum {
  fresh,
  junior,
  midLevel,
  senior;

  static List<String> getNames() => [
        fresh.name,
        junior.name,
        midLevel.name,
        senior.name,
      ];

  static LevelEnum fromString(String name) {
    return values.firstWhere(
      (newName) => newName.name == name,
      orElse: () => throw ArgumentError('Invalid value: $name'),
    );
  }
}
