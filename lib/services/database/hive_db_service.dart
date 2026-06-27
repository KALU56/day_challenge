import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveDbService {
  Future<void> init();
  Future<Box<T>> openBox<T>(String name);
  Future<void> clearAll();
}
