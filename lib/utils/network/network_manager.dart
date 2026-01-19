import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../common/widgets/loaders/loaders.dart';

class NetworkManager extends GetxController{
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> resultList) async{
    if(resultList.length == 1 && resultList[0] == ConnectivityResult.none){
      _connectionStatus.value = ConnectivityResult.none;
      Loaders.warningSnackBar(title: "No Internet Connection");
    }else{
      if(resultList.contains(ConnectivityResult.wifi)){
        _connectionStatus.value = ConnectivityResult.wifi;
      }else if(resultList.contains(ConnectivityResult.mobile)){
        _connectionStatus.value = ConnectivityResult.mobile;
      }else{
        _connectionStatus.value = resultList.first;
      }
    }
  }
  Future<bool> isConnected()async{
    try{
      final resultList = await _connectivity.checkConnectivity();
      if(resultList.length == 1 && resultList[0] == ConnectivityResult.none){
        return false;
      }else{
        return true;
      }
    }on PlatformException catch (_){
      return false;
    }
  }

  @override void onClose() {
    // TODO: implement onClose
    super.onClose();
    _connectivitySubscription.cancel();
  }
}