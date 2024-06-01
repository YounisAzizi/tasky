enum UiStatus {
  all,
  inprogress,
  waiting,
  finished;

  static List<String> getNames() => [
        inprogress.name,
        waiting.name,
        finished.name,
      ];

  static UiStatus fromString(String name) {
    return values.firstWhere(
      (newName) => newName.name == name,
      orElse: () => throw ArgumentError('Invalid value: $name'),
    );
  }
}
