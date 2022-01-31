import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/cubit/file_cubit.dart';
import 'package:poly_forum/screens/shared/components/base_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'offer_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CompanyOfferCubit(),
          ),
          BlocProvider(
            create: (context) => FileCubit(),
          ),
        ],
        child: const OfferForm(),
      ),
      width: 1200,
    );
  }
}
