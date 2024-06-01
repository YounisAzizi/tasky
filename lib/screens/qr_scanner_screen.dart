import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../routes/routes.dart';
import '../../theme/colors.dart';
import '../state_managers/screens/qr_scanner_screen_provider.dart';
import '../utils/utils.dart';

class QrScannerScreen extends ConsumerWidget {
  const QrScannerScreen({super.key});



  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        context.go(Routes.mainScreen);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                context.go(Routes.mainScreen);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildOverView(context,ref),
            Positioned(bottom: 10, child: buildResult(context,ref)),
            Positioned(top: 10, child: buildControlButtons(context,ref))
          ],
        ),
      ),
    );
  }

  Widget buildControlButtons(BuildContext context,WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () async {
                await ref.read(qrScannerProvider).qrController?.toggleFlash();
              },
              icon: Icon(Icons.flash_off,color: Colors.white,)),
          IconButton(
              onPressed: () async {
                await ref.read(qrScannerProvider).qrController?.flipCamera();
              },
              icon: Icon(Icons.switch_camera,color: Colors.white))
        ],
      ),
    );
  }

  Widget buildResult(BuildContext context,WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white24),
      child: Text(
        ref.watch(qrScannerProvider).result != null ? '${ref.watch(qrScannerProvider).result?.code}' : 'Scan a code',
        maxLines: 3,
      ),
    );
  }

  Widget buildOverView(BuildContext context,WidgetRef ref) {
    return QRView(
      onQRViewCreated: (controller) {
        ref.read(qrScannerProvider).setController(controller);
        controller.scannedDataStream.listen((scanData) {
          ref.read(qrScannerProvider).setResult(scanData, context);
        });
      },
      key: ref.read(qrScannerProvider).qrKey,
      overlay: QrScannerOverlayShape(
          cutOutSize: Utils.screenWidth(context) * 0.8,
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 20,
          borderColor: AppColors.mainThemColor),
    );
  }

  void onQrViewCreated(QRViewController controller,WidgetRef ref,BuildContext context) {
    ref.read(qrScannerProvider).setController(controller);
    controller.scannedDataStream.listen((scanData) {
      ref.read(qrScannerProvider).setResult(scanData,context);
    });
  }

}

