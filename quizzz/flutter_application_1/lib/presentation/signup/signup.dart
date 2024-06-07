import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../resources/color_manager.dart';
import '../signin/signin.dart';
import '../widgets/widgets.dart';

class SignupView extends StatefulWidget {

  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _displayNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool obscureText=true;

  bool obscureText1=true;

  @override
  Widget build(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Mutation(
      options: MutationOptions(
        document: gql('''
          mutation CreateUser(\$userInput: UserInput!) {
            createUser(userInput: \$userInput) {
              id
              email
              displayName
              password
            }
          }
        '''),
        onCompleted: (data) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
          );
        },
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unexpected error'),
            ),
          );
          // Handle the error if the mutation fails
        },
      ),
      builder: (
        MultiSourceResult<Object?> Function(Map<String, dynamic>,
                {Object? optimisticResult})
            runMutation,
        QueryResult<Object?>? result,
      ) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorManger.lightPrimary,
            body: Column(
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
                          Text(
                            'Create an account',
                            style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            cursorColor: Colors.grey,
                            controller: _displayNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person_rounded,
                                  color: Colors.grey),
                              hintText: 'Your Name',
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.grey),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorManger.green),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            cursorColor: Colors.grey,
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: Colors.grey),
                              hintText: 'Email',
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.grey),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorManger.green),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            cursorColor: Colors.grey,
                            controller: _passwordController,
                            style: const TextStyle(color: Colors.white),
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_rounded,
                                  color: Colors.grey),
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
                              hintText: 'Password',
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.grey),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorManger.green),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextField(
                            cursorColor: Colors.grey,
                            controller: _confirmPasswordController,
                            style: const TextStyle(color: Colors.white),
                            obscureText: obscureText1,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_rounded,
                                  color: Colors.grey),
                                  suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureText1 = !obscureText1;
                                  });
                                },
                                child: Icon(
                                  obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Confirm password',
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.grey),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorManger.green),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_confirmPasswordController.text.isEmpty ||
                                  _emailController.text.isEmpty ||
                                  _displayNameController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('All fields are required'),
                                  ),
                                );
                              } else if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password does not match'),
                                  ),
                                );
                              } else if (!_emailController.text
                                  .endsWith('@esi-sba.dz')) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Email must end with "@esi-sba.dz"'),
                                  ),
                                );
                              } else {
                                runMutation({
                                  'userInput': {
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                    'displayName': _displayNameController.text,
                                  },
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              minimumSize: const Size(200, 50),
                              backgroundColor: ColorManger.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'already have an account? login here',
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
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
        );
      },
    );
  }
}
