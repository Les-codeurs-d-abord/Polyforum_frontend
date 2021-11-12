import 'package:flutter/material.dart';
import 'package:poly_forum/constants.dart';
import 'package:poly_forum/cubit/sign_in_screen_cubit.dart';
import 'package:poly_forum/screens/sign_in/components/email_form_field.dart';
import 'package:poly_forum/screens/sign_in/components/pwd_forget.dart';
import 'package:poly_forum/screens/sign_in/components/pwd_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/sign_in/components/pwd_save.dart';

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
              "images/logo_temp.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              "Connexion",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 80),
            EmailFormField(_emailController),
            const SizedBox(height: 30),
            PwdFormField(_passwordController),
            const SizedBox(height: 10),
            const PwdSave(),
            const SizedBox(height: 70),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: kButtonColor,
                  onSurface: Colors.grey,
                  // minimumSize: const Size(250, 60),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    BlocProvider.of<SignInScreenCubit>(context)
                        .navigateToHomeScreenEvent(
                            _emailController.text, _passwordController.text);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(),
                    Text(
                      "Se connecter",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.arrow_forward_outlined),
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
