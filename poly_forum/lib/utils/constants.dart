import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
// RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const kScaffoldColor = Colors.white;
const kTextColor = Colors.black;

//à voir
//text (noir - bleu foncé)
final kPrimaryColor = Colors.blue[300];

//background (bleu clair)
const kSecondaryColor = Colors.blue;

//button (orange ?)
const kButtonColor = Color(0xFF0D47A1);

// Main color palette
const kOrange = Color(0xFFF7931D);
const kDarkBlue = Color(0xFF004876);
const kBlue = Color(0xFF00AEEF);
const kLightBlue = Color(0xFFA8E2FA);

// Server IP
const kServer = "localhost:8080";

// Preferences name
const kTokenPref = "token";
const kEmailPref = "email";
const kPwdPref = "password";
const kSavePwd = "save_password";

const kDelayQuery = 1000;

EdgeInsetsGeometry kTopSnackBarPadding =
    const EdgeInsets.only(left: 300, right: 10);

const kRedButton = Colors.red;
