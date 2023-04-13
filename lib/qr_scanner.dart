import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/scan_result.dart';
import 'package:project/overlay.dart';

const C = Colors.cyanAccent;

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanComplete = false;
  bool isFlashOn = false;
  bool isFrontCameraOn = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen(){
    isScanComplete = false;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: C,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isFlashOn = !isFlashOn;
            });
            controller.toggleTorch();
          }, icon: Icon(Icons.flash_on, color: isFlashOn ? Colors.blue : Colors.grey)),
          IconButton(onPressed: (){
            setState(() {
              isFrontCameraOn = !isFrontCameraOn;
            });
            controller.switchCamera();
          },
              icon: Icon(Icons.camera_front, color: isFrontCameraOn ? Colors.blue : Colors.grey)),
        ],
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
        title:
        const Text(
            "QR Scanner",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: Container(
                  color: Colors.cyanAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                          "Place QR Code in the area",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          )
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: controller,
                      allowDuplicates: true,
                      onDetect: (barcode, args) {if(!isScanComplete){
                        String code = barcode.rawValue ?? '---';
                        isScanComplete = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:(context)=> ScanResult(
                                    closeScreen: closeScreen,
                                    code: code
                                )
                            )
                        );
                      }},
                    ),
                    const QRScannerOverlay(overlayColour: C),
                  ],
                )
            ),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                      "Developed by Flutter",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        letterSpacing: 1,
                      )
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}