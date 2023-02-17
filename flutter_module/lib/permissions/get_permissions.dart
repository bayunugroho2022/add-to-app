import 'platform_impl/stub.dart'
    if (dart.library.io) 'platform_impl/mobile.dart'
    if (dart.library.html) 'platform_impl/web.dart';

class GetPermission {
  final PermissionManagerImpl _permissionManagerImpl;

  GetPermission() : _permissionManagerImpl = PermissionManagerImpl();

  Future<bool> status() async {
    return await _permissionManagerImpl.status();
  }
}
