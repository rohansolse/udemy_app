import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_app/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
