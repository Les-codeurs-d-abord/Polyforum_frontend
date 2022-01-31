import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:poly_forum/data/models/admin_model.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/cubit/sign_in_screen_cubit.dart';
import 'package:poly_forum/screens/sign_in/components/email_form_field.dart';
import 'package:poly_forum/screens/sign_in/components/pwd_forget.dart';
import 'package:poly_forum/screens/sign_in/components/pwd_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/sign_in/components/pwd_save.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInScreenCubit, SignInScreenState>(
      listener: (context, state) {
        print(state);
        if (state is SignInScreenError) {
          showTopSnackBar(
            context,
            const CustomSnackBar.error(
              message: "Une erreur est survenue.",
            ),
          );
        } else if (state is SignInScreenInvalidUserError) {
          showTopSnackBar(
            context,
            const CustomSnackBar.error(
              message: "Identifiants incorrects",
            ),
          );
        } else if (state is SignInScreenLoaded) {
          String? path;

          if (state.user is CandidateUser) {
            path = Routes.candidatScreen;
          } else if (state.user is CompanyUser) {
            path = Routes.companyScreen;
          } else if (state.user is AdminUser) {
            path = Routes.adminScreen;
          }

          if (path != null) {
            Application.router.navigateTo(
              context,
              path,
              clearStack: true,
              transition: TransitionType.fadeIn,
            );
          } else {
            Application.router.navigateTo(
              context,
              Routes.error500Screen,
              transition: TransitionType.fadeIn,
            );
          }
        }
      },
      builder: (context, state) {
        if (state is SignInScreenLoading) {
          return buildScreen(context, true, false);
        } else if (state is SignInScreenInvalidUserError) {
          return buildScreen(context, false, true);
        } else {
          return buildScreen(context, false, false);
        }
      },
    );
  }

  Widget buildScreen(BuildContext context, bool isLoading, bool isError) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 100,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "images/logo.jpg",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              "Connexion",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 30),
            EmailFormField(_emailController),
            const SizedBox(height: 30),
            PwdFormField(_passwordController),
            const SizedBox(height: 10),
            const PwdSave(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: kButtonColor,
                  onSurface: Colors.grey,
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          BlocProvider.of<SignInScreenCubit>(context)
                              .navigateToHomeScreenEvent(_emailController.text,
                                  _passwordController.text);
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Se connecter",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 10),
            const PwdForget(),
          ],
        ),
      ),
    );
  }
}
