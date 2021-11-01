import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/sign_in_screen_cubit.dart';
import 'package:poly_forum/screens/sign_in/components/email_form_field.dart';
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
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Connexion",
              style: Theme.of(context).textTheme.headline5,
            ),
            EmailFormField(_emailController),
            const SizedBox(height: 30),
            PwdFormField(_passwordController),
            const PwdSave(),
            const SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.orange,
                onSurface: Colors.grey,
                minimumSize: const Size(250, 60),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  BlocProvider.of<SignInScreenCubit>(context)
                      .navigateToHomeScreenEvent(
                          _emailController.text, _passwordController.text);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Se connecter",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => print("Mdp oublié"),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                ),
                child: const Text("Mot de passe oublié ?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
