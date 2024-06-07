import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../resources/color_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';

class QuestionDetailView extends StatelessWidget {
  final Question question;
  const QuestionDetailView({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManger.darkgrey,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: screenWidth * 0.14),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      backgroundColor: ColorManger.lightPrimary,
      body: Container(
        // padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.2,
              width: 500,
              child: Center(
                child: Image.asset("images/undraw.png"),
              ),
            ),
            Expanded(
              child: RoundedHome(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white,
                              width: 0.1,
                            )),
                        child: Text(
                          question.question,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 55.0 * question.propositions.length,
                        child: ListView.builder(
                          itemCount: question.propositions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 40,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: question.correctAnswer ==
                                          question.propositions.values
                                              .elementAt(index)
                                              .toString()
                                      ? ColorManger.lightGreen
                                      : ColorManger.lightPrimary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  question.propositions.values
                                      .elementAt(index)
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      // Text(
                      //   '¦ You answered ¦',
                      //   style: GoogleFonts.poppins(
                      //     textStyle: const TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   height: 40,
                      //   margin: const EdgeInsets.all(25),
                      //   decoration: BoxDecoration(
                      //       color: question.correctAnswer ==
                      //               question.selectedAnswer
                      //           ? ColorManger.lightGreen
                      //           : Color.fromARGB(255, 152, 15, 5),
                      //       borderRadius: BorderRadius.circular(15)),
                      //   child: Center(
                      //     child: Text(
                      //       question.selectedAnswer,
                      //       style: GoogleFonts.poppins(
                      //         textStyle: const TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 6,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
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
