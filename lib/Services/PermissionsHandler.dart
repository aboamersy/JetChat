import 'package:permission_handler/permission_handler.dart';

void requestPermission(
    {Permission permission,
    Function onGranted,
    Function onDenied,
    Function onPermanentlyDenied}) async {
  var status = await permission.request();
  if (status.isGranted) onGranted();
  if (status.isDenied) onDenied();
  if (status.isPermanentlyDenied) onPermanentlyDenied();
}
