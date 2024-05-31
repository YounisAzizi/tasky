import 'package:Tasky/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final String id;

  const QRCodeWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: QrImageView(
        data: id,
        version: QrVersions.auto,
        size: Utils.screenWidth(context),
      ),
    );
  }
}
