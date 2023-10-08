import 'package:flutter/cupertino.dart';

const primaryColor = Color.fromARGB(255, 25, 95, 175);
const secondaryColor = Color.fromARGB(255, 120, 176, 240);
const darkColor = Color.fromARGB(255, 109, 115, 180);

const primaryGradient = LinearGradient(colors: [
  Color.fromARGB(255, 25, 95, 175),
  Color.fromARGB(255, 56, 146, 250),
], begin: Alignment.bottomLeft, end: Alignment.topRight);

const secondaryGradient = LinearGradient(
    colors: [Color(0XFF3a3d5f), Color(0XFF84BD00)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);

const darkGradient = LinearGradient(
    colors: [Color(0XFF3a3d5f), Color(0XFF2b5c5a)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);

const secondaryGradientAlt = LinearGradient(
    colors: [Color(0XFF618A02), Color(0XFF84BD00)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);

const darkGradientAlpha = LinearGradient(
    colors: [Color(0XFF1C1F2F), Color(0XFF162D2D)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight);
