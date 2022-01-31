import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/password/change_password_cubit.dart';
import 'package:poly_forum/data/models/user_model.dart';
import 'package:poly_forum/resources/password_repository.dart';

import 'components/body.dart';

class ChangePasswordScreen extends StatelessWidget {
  final User user;

  const ChangePasswordScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChangePasswordCubit(PasswordRepository()),
      child: Body(user),
    );
  }
}
