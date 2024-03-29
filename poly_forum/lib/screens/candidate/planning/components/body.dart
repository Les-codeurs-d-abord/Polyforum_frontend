import 'package:flutter/material.dart';
import 'package:poly_forum/cubit/candidate/candidate_planning_screen_cubit.dart';
import 'package:poly_forum/data/models/candidate_user_model.dart';
import 'package:poly_forum/data/models/planning_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_forum/screens/candidate/planning/components/slot_component.dart';
import 'package:shimmer/shimmer.dart';

class Body extends StatefulWidget {
  final CandidateUser user;

  const Body({Key? key, required this.user}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Planning? planning;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CandidatePlanningScreenCubit>(context)
        .planningEvent(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidatePlanningScreenCubit,
        CandidatePlanningScreenState>(listener: (context, state) {
      if (state is CandidatePlanningScreenError) {
      } else if (state is CandidatePlanningScreenLoaded) {
        planning = state.planning;
      }
    }, builder: (context, state) {
      if (state is CandidatePlanningScreenLoading) {
        return buildloadingScreen();
      } else if (state is CandidatePlanningScreenLoaded) {
        return buildLoadedScreen(state.planning);
      }
      return buildInitialPlanning();
    });
  }

  Widget buildInitialPlanning() {
    return Image.asset(
      "images/no_result.jpg",
    );
  }

  Widget buildloadingScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < 7; i++)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
              ],
            ),
          ),
          itemCount: 4,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      ),
    );
  }

  Widget buildLoadedScreen(Planning? planning) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: Text(
              "Planning du 5 mars 2022",
              style: Theme.of(context).textTheme.headline3,
            )),
        Expanded(
          child: planning != null
              ? ListView.separated(
                  padding: const EdgeInsets.only(right: 30, left: 30, top: 10),
                  itemCount: planning.slots.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        height: 1,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return SlotPlanning(
                      slot: planning.slots[index],
                    );
                  })
              : buildInitialPlanning(),
        )
      ],
    );
  }
}
