import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/constants.dart';
import 'package:poly_forum/cubit/admin/company_list/company_list_screen_cubit.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyListScreenCubit, CompanyListScreenState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return buildCompanyListScreen(context);
        }
    );
  }

  buildCompanyListScreen(BuildContext context) {
    return const Scaffold(
      backgroundColor: kScaffoldColor,
    );
  }
}
