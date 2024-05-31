import 'package:Tasky/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final String id;
  final int index;

  const QRCodeWidget({Key? key, required this.id,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: QrImageView(
        data: '${id}/${index}',

        version: QrVersions.auto,
        size: Utils.screenWidth(context),
      ),
    );
  }
}