import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'hive_db_service.dart';

class HiveDbServiceImpl implements HiveDbService {
  @override
  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
  }

  @override
  Future<Box<T>> openBox<T>(String name) async {
    return await Hive.openBox<T>(name);
  }

  @override
  Future<void> clearAll() async {
    await Hive.deleteFromDisk();
  }
}
