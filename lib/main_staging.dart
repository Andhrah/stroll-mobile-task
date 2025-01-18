import 'package:flutter/material.dart';
import 'package:stroll/config/app.dart';
import 'package:stroll/config/app_config.dart';

void main() {
  // Set up configuration for the staging environment
  const config = AppConfig(
    environment: 'staging',
    apiBaseUrl: 'https://api.staging.com',
    enableLogging: true,
  );

  /// Initialize global app settings
  AppConfig.init(config);

  runApp(const MyApp());
}
