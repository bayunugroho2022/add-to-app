import 'dart:html';
import 'base.dart';

class PermissionManagerImpl extends PermissionStatus {
  @override
  Future<bool> status() async {
    final ps = await window.navigator.permissions?.query({'name': 'geolocation'});

    if (ps == null) {
      return false;
    }

    return ps.state == 'granted';
  }
}
