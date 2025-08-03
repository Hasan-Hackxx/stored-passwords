import 'package:flutter/widgets.dart' show BuildContext, ModalRoute;

extension Getargument on BuildContext {
  T? getArgument<T>() {
    final modelroute = ModalRoute.of(this);
    if (modelroute != null) {
      final args = modelroute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
