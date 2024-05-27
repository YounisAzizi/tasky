import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPriorityProvider = StateProvider<String>((ref){
  return 'medium';
});

final prioritiesListProvider = StateProvider<List<String>>((ref){
  return ['low', 'medium', 'high'];
});