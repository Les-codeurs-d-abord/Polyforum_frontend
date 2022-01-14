import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static const String signInScreen = "/connexion";
  static const String candidatScreen = "/candidat";
  static const String companyScreen = "/entreprise";
  static const String adminScreen = "/admin";
  static const String error404Screen = "/error404";
  static const String error500Screen = "/error500";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFoundHandler;

    router.define(signInScreen, handler: signInHandler);
    router.define(candidatScreen, handler: candidateHandler);
    router.define(companyScreen, handler: companyHandler);
    router.define(adminScreen, handler: adminHandler);

    router.define(error404Screen, handler: error404Handler);
    router.define(error500Screen, handler: error500Handler);
  }
}
