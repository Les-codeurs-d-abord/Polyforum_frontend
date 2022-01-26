import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:poly_forum/cubit/admin/dashboard/side_panel_cubit.dart';
import 'package:poly_forum/cubit/phase_cubit.dart';
import 'package:poly_forum/screens/admin/dashboard/components/survey_link_dialog.dart';
import 'package:poly_forum/screens/shared/components/form/form_return_enum.dart';
import 'package:poly_forum/screens/shared/components/modals/confirmation_modal.dart';
import 'package:poly_forum/screens/shared/components/phase.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({Key? key}) : super(key: key);

  @override
  _SidePanelState createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  final _surveyLinkController = TextEditingController();

  Phase? currentPhase;

  @override
  void initState() {
    super.initState();
    currentPhase = BlocProvider.of<PhaseCubit>(context).getCurrentPhase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SidePanelCubit, SidePanelState>(
        listener: (context, state) {
          if (state is SidePanelError) {
            showTopSnackBar(
              context,
              Padding(
                padding: kTopSnackBarPadding,
                child: CustomSnackBar.error(
                  message: state.errorMessage,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SidePanelButtonLoading) {
            return buildSidePanel(context, isLoading: true);
          } else {
            return buildSidePanel(context);
          }
        }
    );
  }

  Widget buildSidePanel(context, {bool isLoading = false}) {
    return Column(
      children: [
        buildPhaseInformations(currentPhase),
        Container(
          width: 300,
          height: 60,
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: kButtonColor,
          ),
          child: buildPhaseButton(currentPhase, isLoading),
        ),
      ],
    );
  }

  Widget buildPhaseInformations(Phase? phase) {
    if (phase == Phase.inscription) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            child: Text(
              "Période courante : Période d'inscription ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          JustTheTooltip(
            content: Container(
              width: 250,
              padding: const EdgeInsets.all(5),
              child: const Text(
                "Durant cette période, vous pouvez ajouter et supprimer des candidats et des entreprises.\n"
                    "Ces derniers doivent ensuite compléter leur profil respectif pour pouvoir participer au forum.\n"
                    "Les entreprises doivent également renseigner des offres.",
              ),
            ),
            child: const Icon(Icons.info),
          )
        ],
      );
    } else if (phase == Phase.wish) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            child: Text(
              "Période courante : Réalisation des voeux ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          JustTheTooltip(
            content: Container(
              width: 250,
              padding: const EdgeInsets.all(5),
              child: const Text(
                "Durant cette période les entreprises et les candidats font leurs voeux.\n"
                    "Il n'est plus possible de modifier les offres et les profils.",
              ),
            ),
            child: const Icon(Icons.info),
          )
        ],
      );
    } else if (phase == Phase.planning) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            child: Text(
              "Période courante : Plannings générés ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          JustTheTooltip(
            content: Container(
              width: 250,
              padding: const EdgeInsets.all(5),
              child: const Text(
                  "Les plannings des entretiens ont été générés et sont désormais visibles.\n"
                      "L'organisateur a la possibilité d'ajouter ou supprimer des créneaux "
                      "et peut également diffuser un questionnaire de satisfaction lorsque les entretiens sont terminés."
              ),
            ),
            child: const Icon(Icons.info),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget buildPhaseButton(Phase? phase, bool isLoading) {
    if (phase == Phase.inscription) {
      return MaterialButton(
        child: isLoading ?
        const SizedBox(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
          width: 20,
          height: 20,
        ) :
        const Text(
          "Cloturer les inscriptions",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22
          ),
        ),
        onPressed: () {
          isLoading ?
          null :
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ConfirmationModal(
                    title: "Cloturer les inscriptions",
                    description: "Vous êtes sur le point de cloturer la période des inscriptions pour passer au renseignement des voeux. "
                        "Les utilisateurs dont le profil est incomplet ne pourront pas participer au forum."
                );
              },
              barrierDismissible: true
          ).then((value) {
            if (value == ModalReturn.confirm) {
              BlocProvider.of<SidePanelCubit>(context).setWishPhase().then((value) {
                BlocProvider.of<PhaseCubit>(context).fetchCurrentPhase();
                showTopSnackBar(
                  context,
                  Padding(
                    padding: kTopSnackBarPadding,
                    child: const CustomSnackBar.success(
                      message: "Phase d'inscription cloturée avec succès, le renseignement des voeux est disponible.",
                    ),
                  ),
                );
              });
            }
          });
        },
      );
    } else if (phase == Phase.wish) {
      return MaterialButton(
        child: isLoading ?
        const SizedBox(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
          width: 20,
          height: 20,
        ) :
        const Text(
          "Générer les plannings",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22
          ),
        ),
        onPressed: () {
          isLoading ?
          null :
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const ConfirmationModal(
                  title: "Générer les plannings",
                  description: "Vous êtes sur le point de cloturer la période de renseignement des voeux pour passer à la génération des plannings. "
                      "Il ne sera plus possible de modifier les voeux et les utilisateurs n'ayant fait aucun voeux ne seront pas pris en compte.",
                );
              },
              barrierDismissible: true
          ).then((value) {
            if (value == ModalReturn.confirm) {
              BlocProvider.of<SidePanelCubit>(context).setPlanningPhase().then((value) {
                BlocProvider.of<PhaseCubit>(context).fetchCurrentPhase();
                showTopSnackBar(
                  context,
                  Padding(
                    padding: kTopSnackBarPadding,
                    child: const CustomSnackBar.success(
                      message: "Phase de renseignement des voeux cloturée avec succès, les plannings sont disponibles.",
                    ),
                  ),
                );
              });
            }
          });
        },
      );
    } else if (phase == Phase.planning) {
      return MaterialButton(
        child: isLoading ?
        const SizedBox(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
          width: 20,
          height: 20,
        ) :
        const Text(
          "Envoyer un questionnaire de satisfaction",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
        onPressed: () {
          isLoading ?
          null :
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SurveyLinkDialog(_surveyLinkController);
              },
              barrierDismissible: true
          ).then((value) {
            if (value == FormReturn.confirm) {
              BlocProvider.of<SidePanelCubit>(context).sendSatisfactionSurvey(_surveyLinkController.text).then((value) {
                showTopSnackBar(
                  context,
                  Padding(
                    padding: kTopSnackBarPadding,
                    child: const CustomSnackBar.success(
                      message: "Le questionnaire de satisfaction a bien été envoyé.",
                    ),
                  ),
                );
              });
            }
          });
        },
      );
    } else {
      return Container();
    }
  }
}
