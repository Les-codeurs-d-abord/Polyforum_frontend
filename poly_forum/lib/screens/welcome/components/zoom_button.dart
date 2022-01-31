import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:poly_forum/utils/constants.dart';

class ZoomButtonsPluginOption extends LayerOptions {
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;

  ZoomButtonsPluginOption({
    Key? key,
    this.minZoom = 1,
    this.maxZoom = 18,
    this.mini = true,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
    this.zoomInColor,
    this.zoomInColorIcon,
    this.zoomInIcon = Icons.zoom_in,
    this.zoomOutColor,
    this.zoomOutColorIcon,
    this.zoomOutIcon = Icons.zoom_out,
    Stream<Null>? rebuild,
  }) : super(key: key, rebuild: rebuild);
}

class ZoomButtonsPlugin implements MapPlugin {
  @override
  Widget createLayer(
      LayerOptions options, MapState mapState, Stream<Null> stream) {
    if (options is ZoomButtonsPluginOption) {
      return ZoomButtons(options, mapState, stream);
    }
    throw Exception('Unknown options type for ZoomButtonsPlugin: $options');
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is ZoomButtonsPluginOption;
  }
}

class ZoomButtons extends StatelessWidget {
  final ZoomButtonsPluginOption zoomButtonsOpts;
  final MapState map;
  final Stream<Null> stream;
  final FitBoundsOptions options =
      const FitBoundsOptions(padding: EdgeInsets.all(12.0));

  ZoomButtons(this.zoomButtonsOpts, this.map, this.stream)
      : super(key: zoomButtonsOpts.key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: zoomButtonsOpts.alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: zoomButtonsOpts.mini,
              backgroundColor: kPrimaryColor,
              onPressed: () {
                var bounds = map.getBounds();
                var centerZoom = map.getBoundsCenterZoom(bounds, options);
                var zoom = centerZoom.zoom + 1;
                if (zoom > zoomButtonsOpts.maxZoom) {
                  zoom = zoomButtonsOpts.maxZoom;
                }
                map.move(centerZoom.center, zoom,
                    source: MapEventSource.custom);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: zoomButtonsOpts.mini,
              backgroundColor: kPrimaryColor,
              onPressed: () {
                var bounds = map.getBounds();
                var centerZoom = map.getBoundsCenterZoom(bounds, options);
                var zoom = centerZoom.zoom - 1;
                if (zoom < zoomButtonsOpts.minZoom) {
                  zoom = zoomButtonsOpts.minZoom;
                }
                map.move(centerZoom.center, zoom,
                    source: MapEventSource.custom);
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
