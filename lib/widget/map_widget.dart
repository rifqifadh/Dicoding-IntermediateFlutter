import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;

class StoryMapWidget extends StatefulWidget {
  final LatLng position;

  const StoryMapWidget({
    Key? key,
    required this.position,
  }) : super(key: key);

  @override
  State<StoryMapWidget> createState() => _StoryMapWidgetState();
}

class _StoryMapWidgetState extends State<StoryMapWidget> {
  late GoogleMapController mapController;

  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    defineMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GoogleMap(
            markers: markers,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationEnabled: false,
            zoomGesturesEnabled: false,
            initialCameraPosition:
                CameraPosition(target: widget.position, zoom: 18),
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
              defineMarker();
            },
          ),
        ],
      ),
    );
  }

  void defineMarker() async {
    final info = await geo.placemarkFromCoordinates(
      widget.position.latitude,
      widget.position.longitude,
    );
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: widget.position,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(widget.position, 18),
        );
      },
    );
    markers.add(marker);
  }
}
