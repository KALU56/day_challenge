import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'services/database/hive_db_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final dbService = HiveDbServiceImpl();
  await dbService.init();

  runApp(
    const ProviderScope(
      child: DayChallengeApp(),
    ),
  );
}
