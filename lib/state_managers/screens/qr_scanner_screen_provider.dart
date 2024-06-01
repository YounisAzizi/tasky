import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes.dart';

class QrScanner extends ChangeNotifier {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;
  Barcode? get result =>_result;

  QRViewController? _qrController;
  QRViewController? get qrController =>_qrController;

  bool _isScanner = false;
  bool get isScanner =>_isScanner;

  void setIsScan(bool isScan){
    _isScanner = isScan;
  }
  void setController(QRViewController controller) {
    _qrController = controller;
    notifyListeners();
  }

  void setResult(Barcode result, BuildContext context) {
    _result = result;
    notifyListeners();

    if (result.code != null) {

      context.go('${Routes.taskDetails.replaceFirst(':index', '${result.code?.substring(25, 26)}')}');
    }
  }

  void toggleFlash() async {
    await _qrController?.toggleFlash();
    notifyListeners();
  }

  void flipCamera() async {
    await _qrController?.flipCamera();
    notifyListeners();
  }

  void disposeController() {
    _qrController?.dispose();
  }

  void reassemble() {
    if (_qrController != null) {
      if (Platform.isAndroid) {
        _qrController!.pauseCamera();
      }
      _qrController!.resumeCamera();
    }
  }
}


final qrScannerProvider = ChangeNotifierProvider((ref) {
  return QrScanner();
},);
