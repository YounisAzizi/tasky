enum PrioritiesEnum {
  low,
  medium,
  high;

  static List<String> getNames() => [low.name, medium.name, high.name];

  static PrioritiesEnum fromString(String name) {
    return values.firstWhere(
      (newName) => newName.name == name,
      orElse: () => throw ArgumentError('Invalid value: $name'),
    );
  }
}
