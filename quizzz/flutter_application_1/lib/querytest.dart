// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/resources/color_manager.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


import 'models/graphql.dart';

// ignore: must_be_immutable
class MyWidget extends StatelessWidget {
  String userId;
  MyWidget({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(GraphQl.quizPropaList),
      ),
      builder: (QueryResult? result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result?.hasException == true) {
          return Text(result!.exception.toString());
        }

        if (result?.isLoading == true) {
          return Center(child: CircularProgressIndicator());
        }
        final List<dynamic>? quizes = result?.data?['quizPropaList'];
        // print(quizes);
        final List<dynamic> filtredQuizes =
            quizes!.where((element) => element['userid'] == userId).toList();
        //print(filtredQuizes);
        return ListView.builder(
            itemCount: filtredQuizes.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    color: ColorManger.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    "  ${filtredQuizes[index]['question']}",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            });
      },
    );
  }
}
