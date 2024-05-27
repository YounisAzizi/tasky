import 'package:flutter_riverpod/flutter_riverpod.dart';

final completeNumberProvider = StateProvider((ref){
  return '';
});

final storeTokenProvider =StateProvider((ref){
  return 'token';
});
final storeIdProvider = StateProvider((ref){
  return 'id';
});
final storeRefreshTokenProvider = StateProvider((ref){
  return 'refreshToken';
});