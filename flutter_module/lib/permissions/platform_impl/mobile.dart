import 'package:permission_handler/permission_handler.dart' as ph;
import 'base.dart';

class PermissionManagerImpl extends PermissionStatus {

  @override
  Future<bool> status() async {
    final ps = await ph.Permission.location.request();
    return ps.isGranted;
  }

}