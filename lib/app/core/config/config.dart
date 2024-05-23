import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppConfig {
  AppConfig({
    required this.baseUrl,
    required this.env,
    required this.log,
    required this.logout,
  });

  final String baseUrl;
  final AppEnv env;
  final Logger log;
  final VoidCallback logout;

  static void logError(error, [stackTrace]) {
    final logger = Logger();
    logger.e([error, stackTrace]);
  }
}

enum AppEnv { prod, dev }
