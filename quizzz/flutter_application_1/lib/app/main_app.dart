import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';


import '../utils/prefrences.dart';
import '/presentation/home/home.dart';
import '/presentation/signin/signin.dart';


// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  bool isLoggedIn;
  MainApp({super.key, required this.isLoggedIn});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late HttpLink httpLink;
  late ValueNotifier<GraphQLClient> client;
  String id = "";
  String displayName = "";
  @override
  void initState() {
    fetchData();
    super.initState();
    httpLink = HttpLink(
      'https://endpoint.astropiole.com/graphQuery',
    );

    client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    // Create QueryOptions for the users query
  }

  Future<void> fetchData() async {
    Prefrences.getDisplayName().then((value) {
      displayName = value;
      Prefrences.getId().then((value) {
        setState(() {
          id = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: 
        // AnswerQuestion(question:myQuestion , userId: '',),
         widget.isLoggedIn
            ? (id.isEmpty
                ? const Scaffold()
                : homeScreen(id: id, displayName: displayName)) 
            : 
            const LoginView(),
      ),
    );
  }
//   Question myQuestion = Question(
//   id: "q1",
//   moduleName: "Mathematics",
//   question: "What is the value of pi?",
//   propositions: {
//     "A": "2.71828",
//     "B": "3.14159",
//     "C": "1.61803",
//     "D": "4.66920",
//   },
//   correctAnswer: "B",
//   selectedAnswer: "",
//   time: 0,
// );

}
