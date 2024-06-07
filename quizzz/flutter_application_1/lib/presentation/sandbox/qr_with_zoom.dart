import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../models/graphql.dart';
import '../../models/models.dart';
import '../answer_question/answer_question.dart';

import '../resources/color_manager.dart';

// ignore: must_be_immutable
class QRScannerPage extends StatefulWidget {
  String userId;
  String displayName;
  List<dynamic> quizes = [];
  QRScannerPage({super.key, required this.userId, required this.displayName,required this.quizes});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late CameraController _cameraController;
  //late QRViewController _qrViewController;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  Future<void> _initializeCamera() async {
     availableCameras().then((value) {
      _cameraController = CameraController(value.first, ResolutionPreset.high);});
      setState(() {
        _cameraController.initialize();
      });
  }

  Future<bool> checkExist(String questionId) async {
  final HttpLink link = HttpLink("https://endpoint.astropiole.com/graphQuery");

  final QueryOptions options = QueryOptions(
    document: gql(r'''
      query Users($userid: ID!, $questionId: ID!) {
        checkQuizIdExists(userid: $userid, questionId: $questionId)
      }
    '''),
    variables: {
      'userid': widget.userId,
      'questionId': questionId,
    },
  );

  final QueryResult result = await GraphQLClient(link: link, cache: GraphQLCache()).query(options);
  
  if (result.hasException) {
    print('Error');
    return false;
  }

  return result.data!['checkQuizIdExists'] as bool;
}



  // bool checkExist(String questionId){

  //   for(int i = 0; i< widget.quizes.length;i++){
  //     if(widget.quizes[i]['questionid'] == questionId){
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  Future<void> fetchData(String questionId)async {
    final HttpLink link =
        HttpLink("https://endpoint.astropiole.com/graphQuery");
    final QueryOptions options = QueryOptions(
      document: gql(GraphQl.getQuizByUserID),
      variables: {
        "getQuizByIdId": questionId,
      },
    );
    QueryResult result =
        await GraphQLClient(link: link, cache: GraphQLCache()).query(options);
        if(result.hasException){
          print("error");
          return;
        }
      Question question = Question.fromJson(result.data!['getQuizByID']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AnswerQuestion(question: question, userId: widget.userId,displayName: widget.displayName,) ));
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildCameraPreview(),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: PinchZoom(
                    //zoomedBackgroundColor: Colors.black,
                    resetDuration: const Duration(milliseconds: 100),
                    maxScale: 3.0,
                    onZoomStart: () {},
                    onZoomEnd: () {},
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: ColorManger.darkGreen,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 void _onQRViewCreated(QRViewController controller) {
  controller.scannedDataStream.listen((scanData) async {
    controller.pauseCamera();
    String questionId = jsonDecode(scanData.code!)['id'];
    
    if (await checkExist(questionId)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Question already answered')));
      Navigator.of(context).pop();
    } else {
      fetchData(questionId);
    }
  });
}


  Widget _buildCameraPreview() {
    final size = MediaQuery.of(context).size;
    try{
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child:  _cameraController.value.isInitialized ?SizedBox(
            width: size.width,
            height: size.width / _cameraController.value.aspectRatio,
            child: Stack(
              children: <Widget>[
                CameraPreview(_cameraController),
              ],
            ),
          ) : Container(),
        ),
      ),
    );
  }
  catch(e){
    return Container();
  }}
  
}
