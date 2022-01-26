import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/cubit/admin/candidate_list/candidate_list_screen_cubit.dart';
import 'package:poly_forum/cubit/admin/company_list/company_list_screen_cubit.dart';
import 'package:poly_forum/cubit/admin/dashboard/dashboard_cubit.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_get_user_cubit.dart';
import 'package:poly_forum/cubit/admin/navigation/admin_navigation_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/resources/candidate_repository.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:poly_forum/routes/application.dart';
import 'package:poly_forum/routes/routes.dart';
import 'package:poly_forum/screens/admin/admin_navigation/components/web/admin_web_body.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<PhaseCubit>(context).fetchCurrentPhase();
    BlocProvider.of<AdminGetUserCubit>(context)
        .getAdminFromLocalToken();
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
      child: BlocConsumer<AdminGetUserCubit, AdminGetUserState>(
        listener: (context, state) {
          if (state is AdminGetUserError) {
            Application.router.navigateTo(
              context,
              Routes.signInScreen,
              clearStack: true,
              transition: TransitionType.fadeIn,
            );
          }
        },
        builder: (context, state) {
          if (state is AdminGetUserLoaded) {
            return buildScreen();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildScreen() {
    final companyRepository = CompanyRepository();
    final candidateRepository = CandidateRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminNavigationCubit(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(companyRepository, candidateRepository),
        ),
        BlocProvider(
          create: (context) => CompanyListScreenCubit(companyRepository),
        ),
        BlocProvider(
          create: (context) => CandidateListScreenCubit(candidateRepository),
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return const AdminWebBody();
        // if (constraints.maxWidth > 1024) {
        //   return const CandidateWebBody();
        // } else {
        //   return const CandidatePhoneBody();
        // }
      }),
    );
  }
}
