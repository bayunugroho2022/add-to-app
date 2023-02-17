import 'base.dart';

class PermissionManagerImpl extends PermissionStatus {

  @override
  Future<bool> status() {
    return Future.value(false);
  }

}