import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:ent/constants/enums.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      var connectionStatus = _getConnectivityStatus(result);
      connectionStatusController.add(connectionStatus);
    });
  }
}

ConnectivityStatus _getConnectivityStatus(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.mobile:
      return ConnectivityStatus.Mobile;
      break;
    case ConnectivityResult.wifi:
      return ConnectivityStatus.Wifi;
      break;
    case ConnectivityResult.none:
      return ConnectivityStatus.Offline;
    default:
      return ConnectivityStatus.Offline;
  }
}
