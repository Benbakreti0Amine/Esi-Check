import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/main_app.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../models/graphql.dart';
import '../../models/models.dart';
import '../resources/color_manager.dart';

import '../resources/values_manager.dart';

// ignore: must_be_immutable
class AnswerQuestion extends StatefulWidget {
  Question question;
  String displayName;
  String userId;
  AnswerQuestion(
      {Key? key,
      required this.question,
      required this.userId,
      required this.displayName})
      : super(key: key);

  @override
  State<AnswerQuestion> createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> {
  late Timer _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    // start the timer when the widget is initialized
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  @override
  void dispose() {
    // stop the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: ColorManger.darkgrey,
        appBar: AppBar(
          backgroundColor: ColorManger.darkgrey,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(width: screenWidth * 0.28),
              Text(
                "Esi",
                style: GoogleFonts.poppins(
                  color: ColorManger.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      offset: Offset(0.5, 0.5),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              Text(
                "-Check",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      offset: Offset(0.5, 0.5),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        body: Container(
          child: Mutation(
            options: MutationOptions(
                document: gql(GraphQl.answerQuiz),
                onCompleted: (dynamic resultData) {
                  // print(resultData);
                },
                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('unexpected error')));
                }),
            builder: (
              RunMutation runMutation,
              QueryResult? result,
            ) {
              return Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                    width: 500,
                    child: Center(
                      child: Image.asset("images/undraw.png"),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorManger.primary,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Time',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                              ),
                              Icon(
                                Icons.timer,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 3),
                              Text(
                                ' ${Duration(seconds: _elapsedSeconds).inSeconds} s',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Container(
                            width: screenWidth*0.9,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.1,
                                )),
                            child: Text(
                              widget.question.question,
                              style: GoogleFonts.poppins(
                                  color: ColorManger.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s20,
                          ),
                          Expanded(
                            child: Container(
                              width: screenWidth * 0.85,
                              child: ListView.builder(
                                itemCount: widget.question.propositions.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.question.selectedAnswer = widget
                                            .question.propositions.values
                                            .elementAt(index)
                                            .toString();
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: AppSize.s10,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: AppSize.s10,
                                        horizontal: AppSize.s10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: widget.question.selectedAnswer ==
                                        
                                                widget
                                                    .question.propositions.values
                                                    .elementAt(index)
                                                    .toString()
                                            ? ColorManger.darkGreen
                                            : ColorManger.darkgrey,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.question.propositions.values
                                              .elementAt(index),
                                          style: GoogleFonts.poppins(
                                            color: ColorManger.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(children: [
                            SizedBox(
                              width: screenWidth * 0.6,
                            ),
                            SizedBox(
                              width: screenWidth * 0.3,
                              child: ElevatedButton(
                                onPressed: () {
                                  _timer.cancel();
                                  widget.question.time = _elapsedSeconds;
                                  _submitAnswer(runMutation);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainApp(isLoggedIn: true)));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManger.orange,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppSize.s15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: AppSize.s40,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _submitAnswer(RunMutation runMutation) {
    runMutation({
      "userid": widget.userId,
      "questionid": widget.question.id,
      "selectedAnswer": widget.question.selectedAnswer,
      "time": _elapsedSeconds,
    });
  }
}
