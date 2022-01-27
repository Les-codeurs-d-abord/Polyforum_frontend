// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:poly_forum/screens/admin/admin_navigation/admin_navigation_screen.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/candidate_navigation_screen.dart';
import 'package:poly_forum/screens/company/company_navigation/campany_navigation_screen.dart';
import 'package:poly_forum/screens/error/error_screen.dart';
import 'package:poly_forum/screens/sign_in/sign_in_screen.dart';

var notFoundHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ErrorScreen("error_404.jpg");
});

var signInHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SignInScreen();
});

var error404Handler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ErrorScreen("error_404.jpg");
});

var error500Handler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const ErrorScreen("error_500.jpg");
});

var candidateHandler = Handler(handlerFunc: (context, params) {
  return const CandidateNavigationScreen();
});

var companyHandler = Handler(handlerFunc: (context, params) {
  return const CompanyNavigationScreen();
});

var adminHandler = Handler(handlerFunc: (context, params) {
  return const AdminNavigationScreen();
});
