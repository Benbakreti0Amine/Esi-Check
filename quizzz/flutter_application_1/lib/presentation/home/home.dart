// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/utils/prefrences.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../models/graphql.dart';
import '../historic/historic_view.dart';
import '../resources/color_manager.dart';
import '../sandbox/qr_with_zoom.dart';
import '../signin/signin.dart';
import 'aboutus.dart';

class homeScreen extends StatefulWidget {
  final String id;
  final String displayName;
  const homeScreen({Key? key, required this.id, required this.displayName})
      : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> with WidgetsBindingObserver {
  List<dynamic> filtredQuizes = [];
  Timer? dataFetchTimer;

  double calculateAverageTime(List<dynamic> quizes) {
    num totalSeconds = 0;
    for (int i = 0; i < quizes.length; i++) {
      if (quizes[i]['time'].isFinite && !quizes[i]['time'].isNaN) {
        try {
          totalSeconds += quizes[i]['time'];
        } catch (e) {
          print(e);
        }
      }
    }

    return totalSeconds / quizes.length;
  }

  int getNumCorrectAnswer(List<dynamic> quizes) {
    int count = 0;
    for (int i = 0; i < quizes.length; i++) {
      if (quizes[i]['selectedAnswer'] == quizes[i]['correctAnswer']) count++;
    }
    return count;
  }

  int getNumIncorrectAnswer(List<dynamic> quizes) {
    int count = 0;
    for (int i = 0; i < quizes.length; i++) {
      if (quizes[i]['selectedAnswer'] != quizes[i]['correctAnswer']) count++;
    }
    return count;
  }

  @override
  void initState() {
    fetchData();
    startDataFetchTimer();

    super.initState();
  }

  @override
  void dispose() {
    stopDataFetchTimer();
    super.dispose();
  }

  void startDataFetchTimer() {
    dataFetchTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      fetchData();
    });
  }

  void stopDataFetchTimer() {
    dataFetchTimer?.cancel();
  }

  Future<void> fetchData() async {
    final HttpLink link =
        HttpLink("https://endpoint.astropiole.com/graphQuery");
    final QueryOptions options = QueryOptions(
      document: gql(GraphQl.getQuizesByUserId),
      variables: {
        "userid": widget.id,
      },
    );
    // QueryResult result =
    GraphQLClient(link: link, cache: GraphQLCache())
        .query(options)
        .then((value) => setState(() {
              filtredQuizes = value.data!['getReponsebyuserId'];
            }));
  }

  bool boolean = true;
  int numCorrectAnswer = 0;
  int numIncorrectAnswer = 0;
  @override
  //7allbeb
  Widget build(BuildContext context) {
    final String displayName = widget.displayName;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManger.darkgrey,
        appBar: AppBar(
          backgroundColor: ColorManger.darkgrey,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(width: screenWidth * 0.16),
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
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              color: ColorManger.darkgrey,
              child: Column(
                children: [
                  Container(
                    height: screenHeight*0.23,
                    child: UserAccountsDrawerHeader(
                      currentAccountPicture: Container(
                      
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                "images/avatar.png"), // Replace with your app logo asset
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      currentAccountPictureSize:  Size(screenWidth*0.2, screenHeight*0.084),
                      accountName:  Container(
                        
                        child: Text(
                            " Good to see you",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              
                              color: Colors.white,
                            )
                          ),
                      ),
                      
                      accountEmail: Text(
                        " $displayName", // Replace with the user's email
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: ColorManger.primary,
                      ),
                    ),
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.info_outline_rounded, color: Colors.white),
                    title: Text(
                      "About Us",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUs()),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.history, color: Colors.white),
                    title: Text(
                      "Historic",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoricView(questions: filtredQuizes,)),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.white),
                    title: Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Prefrences.setId("").then((value) => {
                            Prefrences.setDisplayName("").then((value) {
                              Prefrences.setLoginStatus(false)
                                  .then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginView()),
                                      ));
                            })
                          });
                    },
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  SizedBox(
                    child: Image.asset(
                      "images/logo2.png", // Replace with your app logo asset
                      width: screenWidth * 1.1,
                      height: screenWidth * 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.015),
                  SizedBox(height: screenHeight * 0.001),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: ColorManger.green,
                        child: SizedBox(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.15,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getNumCorrectAnswer(filtredQuizes)
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      'Correct answers',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: screenWidth*0.037),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: ColorManger.red,
                        child: SizedBox(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.15,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getNumIncorrectAnswer(filtredQuizes)
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      'Wrong answers',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: screenWidth*0.037),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: ColorManger.primary,
                      child: SizedBox(
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.15,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${getNumCorrectAnswer(filtredQuizes) + getNumIncorrectAnswer(filtredQuizes)}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  'Total answers',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: screenWidth*0.037,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: ColorManger.darkGreen,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.15,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.alarm, color: Colors.white),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      calculateAverageTime(filtredQuizes)
                                                  .toString() ==
                                              "NaN"
                                          ? "0"
                                          : calculateAverageTime(filtredQuizes)
                                              .toString()
                                              .substring(0, 3),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('sec',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 15))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Average span',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: screenWidth*0.037),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoricView(
                              questions: filtredQuizes,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: ColorManger.histo.withOpacity(0.99),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: ColorManger.red,
                        child: SizedBox(
                          width: screenWidth * 0.87,
                          height: screenHeight * 0.08,
                          child: Center(
                            child: Text(
                              'Check Questions',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: screenHeight * 0.007,
                  ),
                  SizedBox(
                    width: screenWidth * 0.875,
                    height: screenHeight * 0.34,
                    child: ListView.builder(
                      itemCount: filtredQuizes.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 2.6),
                          decoration: BoxDecoration(
                              color: ColorManger.primary,
                              borderRadius: BorderRadius.circular(17)),
                          child: SizedBox(
                            height: screenHeight * 0.061,
                            child: ListTile(
                              title: Text(
                                "  ${filtredQuizes[index]['question']}",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              trailing: filtredQuizes[index]['correctAnswer'] ==
                                      filtredQuizes[index]['selectedAnswer']
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.009),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: const [Color(0xFFEC407A), Color(0xFFFF7043)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => QRScannerPage(
                                  userId: widget.id,
                                  displayName: widget.displayName,
                                  quizes: filtredQuizes,
                                )),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.all(7),
                      ),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        child: Icon(Icons.qr_code_scanner),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: const [
                              Color(0xFFFF7043),
                              Color(0xFFEC407A)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: EdgeInsets.all(13),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
        ),
      ),
    );
  }
}
