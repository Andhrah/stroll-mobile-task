import 'package:flutter/material.dart';
import 'package:stroll/config/app.dart';
import 'package:stroll/config/app_config.dart';

void main() {
  // Set up configuration for the production environment
  const config = AppConfig(
    environment: 'production',
    apiBaseUrl: 'https://api.production.com',
    enableLogging: false,
  );

  /// Initialize global app settings
  AppConfig.init(config);

  runApp(const MyApp());
}
