enum Status {
  inProgress,
  waiting,
  finished;

  static List<String> getNames() => [
        inProgress.name,
        waiting.name,
        finished.name,
      ];
}
