import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../models/graphql.dart';
import '../../utils/prefrences.dart';
import '../home/home.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import '../signup/signup.dart';
import '../widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool clicked = false;
  bool obscureText = true; 
  //String email = "";
  //String password = "";

  Future<void> fetchData() async {
    final HttpLink link =
        HttpLink("https://endpoint.astropiole.com/graphQuery");
    final QueryOptions options = QueryOptions(
      document: gql(GraphQl.login),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      variables: {
        "email": _emailController.text,
        "password": _passwordController.text,
      },
    );
    await GraphQLClient(link: link, cache: GraphQLCache())
        .query(options)
        .then((value) {
      if (value.hasException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(value.exception!.graphqlErrors[0].message.toString())));
        setState(() {
          loading = false;
        });
      } else {
        Prefrences.setLoginStatus(true);
        Prefrences.setId(value.data!['Login']['id']);
        Prefrences.setDisplayName(value.data!['Login']['displayName']);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => homeScreen(
                id: value.data!['Login']['id'],
                displayName: value.data!['Login']['displayName'])));
      }
    });
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: ColorManger.lightPrimary,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.2 / 5,
                child: Image.asset(
                      "images/logo2.png", // Replace with your app logo asset
                      width: screenWidth* 1.3,
                      height: screenHeight *1.4,
                    ),
              ),
              Expanded(
                child: RoundedHome(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        Text(
                          'Welcome',
                          style: GoogleFonts.poppins(
                            color: ColorManger.white,
                            fontSize: AppSize.s40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(
                          'sign in with your account',
                          style: GoogleFonts.poppins(
                            color: ColorManger.darkGreen,
                            fontSize: AppSize.s20,
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        TextField(
                          cursorColor: Colors.grey,
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person_rounded,
                              color: Colors.grey,
                            ),
                            hintText: 'Email',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorManger
                                      .green), // Set border color when the TextField gains focus
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .grey), // Set border color when the TextField is not in focus
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        TextField(
                          cursorColor: Colors.grey,
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_rounded,
                                color: Colors.grey),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: ColorManger.green),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     TextButton(
                        //       child: Text(
                        //         'Forget Password',
                        //         style: GoogleFonts.poppins(
                        //             color: ColorManger.darkGreen),
                        //       ),
                        //       onPressed: () {},
                        //     )
                        //   ],
                        // ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: loading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(14.0),
                                    minimumSize: const Size(200, 50),
                                    backgroundColor: ColorManger.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      loading = true;
                                    });
                                    fetchData();
                                  },
                                  child: Text(
                                    'Sign in ',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        TextButton(
                          child: const Text(
                            'You do not have an account ? create one ',
                            style: TextStyle(color: ColorManger.lightGrey),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SignupView(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
