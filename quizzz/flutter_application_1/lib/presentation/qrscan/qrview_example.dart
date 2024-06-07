
import 'dart:developer';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';


import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../models/graphql.dart';
import '../../models/models.dart';
import '../answer_question/answer_question.dart';

import '../resources/color_manager.dart';

// ignore: must_be_immutable
class QRViewExample extends StatefulWidget {
  //List<Question> questions = [];
  String userId;
  String displayName;
  QRViewExample({Key? key, required this.userId, required this.displayName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  // List<Question> _questions = [];
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool scanning = true;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // double _zoomLevel = 1.0;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void close(BuildContext context) {
    Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
  }
  Future<void> fetchData(String userid)async {
    final HttpLink link =
        HttpLink("https://endpoint.astropiole.com/graphQuery");
    final QueryOptions options = QueryOptions(
      document: gql(GraphQl.getQuizByUserID),
      variables: {
        "getQuizByIdId": userid,
      },
    );
    QueryResult result =
        await GraphQLClient(link: link, cache: GraphQLCache()).query(options);
        if(result.hasException){
          print("error");
          return;
        }
      Question question = Question.fromJson(result.data!['getQuizByID']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AnswerQuestion(question: question, userId: userid,displayName: widget.displayName,) ));
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorManger.darkGreen,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      String userid = scanData.code!;
      fetchData(userid);
      
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
