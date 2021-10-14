/// When the route is not found.
class RouteNotFoundException implements Exception {
  final String message;
  final String path;
  RouteNotFoundException(this.message, this.path);

  @override
  String toString() {
    return "No registered route was found to handle '$path'";
  }
}