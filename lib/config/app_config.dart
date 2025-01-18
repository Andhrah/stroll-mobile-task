/// Configuration class for storing environment-specific settings.
class AppConfig {
  final String environment;
  final String apiBaseUrl;
  final bool enableLogging;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
  });

  static late AppConfig instance;

  /// Initialize AppConfig for the app
  static void init(AppConfig config) {
    instance = config;
  }
}
