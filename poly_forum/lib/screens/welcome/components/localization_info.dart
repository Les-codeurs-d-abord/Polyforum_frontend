import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';
import './zoom_button.dart';
import 'dart:ui' as ui;
import 'dart:html';

class LocalizationInfo extends StatelessWidget {
  const LocalizationInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Localisation",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            child: const Text(
              "15 Bd André Latarjet, 69100 VILLEURBANNE",
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () => launch(
                "https://www.google.fr/maps/place/15+Bd+Andr%C3%A9+Latarjet,+69100+Villeurbanne/@45.7792134,4.8661922,16z/data=!4m5!3m4!1s0x47f4ea98fe122a47:0x32c97ce90d0cf86!8m2!3d45.7792637!4d4.868203?hl=fr"),
          ),
        ),
        SizedBox(
          height: 300,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: getMap(),
          ),
        ),
      ],
    );
  }

  Widget getMap() {
    return FlutterMap(
      options: MapOptions(
          center: LatLng(45.7793547429481, 4.868299882162529),
          zoom: 17.0,
          enableMultiFingerGestureRace: false,
          enableScrollWheel: false,
          plugins: [
            ZoomButtonsPlugin(),
          ]),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text("© OpenStreetMap contributors"),
            );
          },
        ),
        ZoomButtonsPluginOption(
          minZoom: 4,
          maxZoom: 19,
          mini: true,
          padding: 10,
          alignment: Alignment.bottomLeft,
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(45.7793547429481, 4.868299882162529),
              builder: (ctx) => Container(
                child: Image.asset(
                  "images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
