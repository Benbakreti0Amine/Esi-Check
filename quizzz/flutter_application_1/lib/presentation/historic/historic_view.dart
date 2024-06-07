import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';

import '../../models/graphql.dart';
import '../../models/models.dart';

import '../question_details/question_details_view.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

// ignore: must_be_immutable
class HistoricView extends StatefulWidget {
  HistoricView({Key? key, required this.questions}) : super(key: key);
  List<dynamic> questions;
  @override
  State<HistoricView> createState() => _HistoricViewState();
}

class _HistoricViewState extends State<HistoricView> {
  List<dynamic> filteredQuestions = [];
  String? _selectedItem;
  List<String> modules = [];
  List<String> titles = [];

  @override
  void initState() {
    filteredQuestions = widget.questions;
    getModules();
    getTitles();
    // initDrodDownButton();
    super.initState();
  }

  void getTitles() {
    for (int i = 0; i < widget.questions.length; i++) {
      titles.add(widget.questions[i]['question']);
    }
  }

  void getModules() {
    for (int i = 0; i < widget.questions.length; i++) {
      if (!modules.contains(widget.questions[i]['moduleName'])) {
        modules.add(widget.questions[i]['moduleName']);
      }
    }
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorManger.darkgrey,
      appBar: AppBar(
        backgroundColor: ColorManger.darkgrey,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: screenWidth * 0.15),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(Icons.history, size: 30, color: Colors.grey[600]),
              const SizedBox(width: 10),
              Text(
                'History',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 56,
                width: 220,
                child: TextField(
                  style: GoogleFonts.poppins(color: Colors.white),
                  cursorColor: ColorManger.orange,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: ColorManger.primary),
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      filteredQuestions = widget.questions
                          .where((element) => (element['question'] as String)
                              .trim()
                              .toLowerCase()
                              .contains(value.trim().toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width *
                    0.3, // adjust the width as needed
                decoration: BoxDecoration(
                  color: ColorManger.orange,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButton(
                  value: _selectedItem,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        'All Modules',
                        style: GoogleFonts.poppins(color: Colors.white,fontSize: screenWidth*0.035),
                        
                      ),
                    ),
                    ...modules.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (item) {
                    setState(() {
                      _selectedItem = item;
                      filteredQuestions = widget.questions;
                      if (item != null) {
                        filteredQuestions = widget.questions
                            .where((element) => element['moduleName'] == item)
                            .toList();
                      }
                    });
                  },
                  dropdownColor: ColorManger.primary,
                  underline: Container(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  isExpanded: true,
                  style: GoogleFonts.poppins(color: Colors.white),
                  
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(children: [
              Container(
                child: Expanded(
                  child: filteredQuestions.isEmpty
                      ? Center(
                          child: Text(
                            ' No questions for now ',
                            style: GoogleFonts.poppins(
                              fontSize: AppSize.s20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ListView.builder(
                              itemCount: filteredQuestions.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: AppSize.s5),
                                        padding: const EdgeInsets.only(
                                          top: AppSize.s5,
                                          left: AppSize.s30,
                                          bottom: AppSize.s5,
                                        ),
                                        height: AppSize.s60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: ColorManger.primary,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                //height: 10,
                                                width: 250,
                                                child: Text(
                                                  filteredQuestions[index]
                                                      ['question'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: AppSize.s15),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  print(filteredQuestions[index]
                                                      ['id']);
                                                  final HttpLink link = HttpLink(
                                                      "https://endpoint.astropiole.com/graphQuery");
                                                  final QueryOptions options =
                                                      QueryOptions(
                                                    document: gql(GraphQl
                                                        .getQuizByUserID),
                                                    variables: {
                                                      "getQuizByIdId":
                                                          filteredQuestions[
                                                                  index]
                                                              ['questionid']
                                                    },
                                                  );
                                                  GraphQLClient(
                                                          link: link,
                                                          cache: GraphQLCache())
                                                      .query(options)
                                                      .then((value) {
                                                    if (value.data == null) {
                                                      print('null');
                                                      return;
                                                    }
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuestionDetailView(
                                                                question: Question
                                                                    .fromJson(value
                                                                            .data![
                                                                        'getQuizByID'])),
                                                      ),
                                                    );
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.info_outline_rounded,
                                                  color: ColorManger.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
