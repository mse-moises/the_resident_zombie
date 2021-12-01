import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeReaderPage extends StatefulWidget {
  QRCodeReaderPage({Key? key}) : super(key: key);
  static const String route = '/read-qrcode';

  @override
  State<QRCodeReaderPage> createState() => _QRCodeReaderPageState();
}

class _QRCodeReaderPageState extends State<QRCodeReaderPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late QRViewController captureController;

  String readed = "";

  void _onQRViewCreated(QRViewController controllerAux) {
    this.captureController = controllerAux;
    captureController.scannedDataStream.listen((scanData) async {
      ///it reades too fast that sometimes it pop two times when
      ///so it need this one way valve
      if (readed == "") {
        readed = scanData.code;
        Navigator.pop(context, readed); //pop the string readed
      }
    });
  }

  @override
  void dispose() {
    captureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),

            //DARK FILTER

            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOut,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  //Everithing right here will just "cut" the dark filter
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 40,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
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
