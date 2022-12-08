import 'package:connectivity_plus/connectivity_plus.dart';

class ConectivityCheck {
  const ConectivityCheck();

  Future<bool> checkConectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult != ConnectivityResult.none);
  }
}
