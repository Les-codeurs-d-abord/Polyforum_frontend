import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/company/candidat/company_candidat_list_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_get_user_cubit.dart';
import 'package:poly_forum/cubit/company/navigation/company_navigation_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_get_offer_cubit.dart';
import 'package:poly_forum/cubit/company/offer/company_offer_cubit.dart';
import 'package:poly_forum/cubit/company/wishlist/company_get_wishlist_cubit.dart';
import 'package:poly_forum/cubit/info_phase_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/cubit/image_cubit.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/company/company_navigation/components/phone/company_phone_body.dart';
import 'package:poly_forum/screens/company/company_navigation/components/web/company_web_body.dart';
import 'package:poly_forum/utils/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<PhaseCubit>(context).fetchCurrentPhase().then((value) =>
        BlocProvider.of<CompanyGetUserCubit>(context)
            .getCompanyFromLocalToken());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Application.router.navigateTo(
          context,
          Routes.signInScreen,
          clearStack: true,
          transition: TransitionType.fadeIn,
        );
        return Future(() => true);
      },
      child: BlocConsumer<CompanyGetUserCubit, CompanyGetUserState>(
        listener: (context, state) {
          if (state is CompanyGetUserError) {
            Application.router.navigateTo(
              context,
              Routes.signInScreen,
              clearStack: true,
              transition: TransitionType.fadeIn,
            );
          }
        },
        builder: (context, state) {
          if (state is CompanyGetUserLoaded) {
            return buildScreen();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildScreen() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CompanyNavigationCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyGetOfferCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyCandidatListCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyGetWishlistCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyOfferCubit(),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => InfoPhaseCubit(),
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > kWidthBuildWebVersion) {
          kTopSnackBarPadding = const EdgeInsets.only(left: 300, right: 10);
          kIsWebVersion = true;
          return const CompanyWebBody();
        } else {
          kTopSnackBarPadding = const EdgeInsets.only(left: 10, right: 10);
          kIsWebVersion = false;
          return const CompanyPhoneBody();
        }
      }),
    );
  }
}
