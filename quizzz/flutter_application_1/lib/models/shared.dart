export 'shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../presentation/resources/color_manager.dart';
import '../presentation/resources/values_manager.dart';


List<DropdownMenuItem> items = [
  DropdownMenuItem(
    value: -1,
    child: Text(
      'All Modules ',
      style: GoogleFonts.poppins(fontSize: AppSize.s20, color: ColorManger.darkgrey),
    ),
  ),
];

