import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/color_manager.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorManger.lightPrimary,
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_circle_left_outlined, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
        backgroundColor: ColorManger.darkgrey,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.25, 
                color: ColorManger.primary,
                // margin: const EdgeInsets.only(bottom:10 ,left:80 ,right:80 ,top: 10),
                child: Image.asset("images/logo.png"),
                ),// Set the height to half of the screen
            
          
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: ColorManger.lightPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                 Text(
                  'About Us !',
                  style:GoogleFonts.poppins(color: Colors.white , fontSize: 32 , fontWeight:FontWeight.bold),
                ),
                Expanded(       
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManger.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(20),                    
                      padding: const EdgeInsets.all(18.0),
                      
                        child: SingleChildScrollView(
                          child: Text(
                            'Learnify is an interactive classroom framework that is designed to ease professors evaluation of their students comprehension and focus during lectures. The framework includes a dashboard for the professor and a mobile app for students. The dashboard provides visualized statistics data, giving the professor better insight into students focus in real-time. The app is designed to be easy to use, with clear instructions and simple usage. Students can view their historic achievements (evaluation) as well as statistics about everyone present to measure their progress The real-time feedback provided by Learnify enables the professor to adapt their teaching approach to better engage students and improve their understanding of the material. Overall we believe that this framework promotes collaboration and improves learning quality in our country.',
                            style: GoogleFonts.poppins(color: Colors.white , fontSize: 17),
                          ),
                        ),
                      
                    ),
                  ),
                
              ],
            ),

            // Widget for app description
          ),
        ],
      ),
    );
  }
}
