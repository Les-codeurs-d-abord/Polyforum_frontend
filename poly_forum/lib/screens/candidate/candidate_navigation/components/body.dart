import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/candidate/candidate_choices_cubit.dart';
import 'package:poly_forum/cubit/candidate/candidate_offer_screen_cubit.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_get_user_cubit.dart';
import 'package:poly_forum/cubit/candidate/navigation/candidate_navigation_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/cubit/image_cubit.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/components/phone/candidate_phone_body.dart';
import 'package:poly_forum/screens/candidate/candidate_navigation/components/web/candidate_web_body.dart';
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
        BlocProvider.of<CandidateGetUserCubit>(context)
            .getCandidateFromLocalToken());
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
      child: BlocConsumer<CandidateGetUserCubit, CandidateGetUserState>(
        listener: (context, state) {
          if (state is CandidateGetUserError) {
            Application.router.navigateTo(
              context,
              Routes.signInScreen,
              clearStack: true,
              transition: TransitionType.fadeIn,
            );
          }
        },
        builder: (context, state) {
          if (state is CandidateGetUserLoaded) {
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
          create: (context) => CandidateNavigationCubit(),
        ),
        BlocProvider(
          create: (context) => CandidateChoicesCubit(),
        ),
        BlocProvider(
          create: (context) => CandidateOfferScreenCubit(),
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > kWidthBuildWebVersion) {
          kTopSnackBarPadding = const EdgeInsets.only(left: 300, right: 10);
          kIsWebVersion = true;

          return const CandidateWebBody();
        } else {
          kTopSnackBarPadding = const EdgeInsets.only(left: 10, right: 10);
          kIsWebVersion = false;
          return const CandidatePhoneBody();
        }
      }),
    );
  }
}
