import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider = StateNotifierProvider<SelectedDateNotifier, DateTime>((ref) {
  return SelectedDateNotifier(DateTime.now());
});

class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier(DateTime state) : super(state);

  void setDate(DateTime date) {
    state = date;
  }
}
