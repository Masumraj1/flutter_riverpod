class RoutePath {
  static const String basePath = '/';
  static const String counterPage = 'CounterPage';

}

extension RouteBasePathExt on String {
  String get addBasePath => RoutePath.basePath + this;
}
