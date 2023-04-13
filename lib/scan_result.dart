import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

const C = Colors.blueGrey;

class ScanResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const ScanResult({super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              closeScreen();
              Navigator.pop(context);
            },
            icon: const Icon(
                Icons.arrow_back_ios_new_rounded
            ),
            color: Colors.black
        ),
        centerTitle: true,
        title: const Text(
            "QR Scanner",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //show QR code here
            QrImage(
                data: code,
                size: 150,
                version: QrVersions.auto
            ),
            const Text(
                "Scanned Result",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: (){
                  Clipboard.setData(ClipboardData(text: code));
                },
                child: const Text(
                  "COPY",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}