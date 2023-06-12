
class PermissionHandlerHelperModel {
  PermissionsResult permissionsResult;
  String permissionName;

  PermissionHandlerHelperModel({required this.permissionsResult, required this.permissionName});
}
enum PermissionsResult {
  granted, //permission is/already granted
  denied, //user denies the permission
  permanentlyDenied, //user permanently denied the permission, have to manually grant the permission
}
