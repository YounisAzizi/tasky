import 'package:riverpod/riverpod.dart';

final selectedLevelProvider = StateProvider<String?>((ref){
  return null;
});

final levelsProvider = StateProvider<List<String>>((ref){
  return ['fresh', 'junior', 'midLevel','senior'];
});