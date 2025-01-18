import 'package:flutter/material.dart';
import 'package:stroll/config/app.dart'; 
import 'package:stroll/config/app_config.dart';

void main() {
  // Set up configuration for the development environment
  const config = AppConfig(
    environment: 'development',
    apiBaseUrl: 'https://api.dev.com',
    enableLogging: true,
  );

  /// Initialize global app settings
  AppConfig.init(config);

  // Start the Flutter application
  runApp(const MyApp());
}
