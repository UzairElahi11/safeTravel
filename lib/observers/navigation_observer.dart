import 'package:flutter/cupertino.dart';

class PawaNavigationObserver extends NavigatorObserver {
  int statckCount = 0;
  List<Route> routes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    statckCount++;
    debugPrint("didPush");
    routes.add(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    statckCount--;
    debugPrint("didRemove");
    routes.remove(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    statckCount--;
    debugPrint("didPop");
    routes.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? oldRoute, Route<dynamic>? newRoute}) {
    super.didReplace(oldRoute: oldRoute, newRoute: newRoute);
    debugPrint("didReplace");
    routes.add(newRoute!);
  }
}
