import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CustomLocation extends StatefulWidget {
  const CustomLocation({super.key});

  @override
  State<CustomLocation> createState() => _CustomLocationState();
}

class _CustomLocationState extends State<CustomLocation>
    with WidgetsBindingObserver {
  LatLng? selectedLocation;
  LatLng? initialLocation;
  String? placeName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getUserLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && initialLocation == null) {
      _getUserLocation();
    }
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      await _getUserLocation();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        initialLocation = LatLng(position.latitude, position.longitude);
      });
    }
  }

  Future<void> _getPlaceName(LatLng location) async {
    try {
      if (mounted) {
        setState(() {
          placeName = "جارٍ تحديد الموقع...";
        });
      }

      final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse"
        "?lat=${location.latitude}"
        "&lon=${location.longitude}"
        "&format=json"
        "&accept-language=ar",
      );

      final response = await http
          .get(url, headers: {"User-Agent": "ServiGoApp/1.0"})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        debugPrint("Nominatim response: $data");

        final address = data['address'];
        final name = [
          address['amenity'],
          address['building'],
          address['shop'],
          address['leisure'],
          address['road'],
          address['neighbourhood'] ?? address['suburb'] ?? address['quarter'],
          address['city'] ?? address['town'] ?? address['village'],
        ].where((e) => e != null && (e as String).isNotEmpty).join(', ');
        if (mounted) {
          setState(() {
            placeName = name.isNotEmpty ? name : data['display_name'];
          });
        }
      } else {
        if (mounted) {
          setState(() {
            placeName =
                "${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}";
          });
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (mounted) {
        setState(() {
          placeName =
              "${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: initialLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: initialLocation!,
                    initialZoom: 15,
                    onTap: (tapPosition, point) async {
                      debugPrint("Map tapped: $point"); // ← أضف
                      if (mounted) {
                        setState(() {
                          selectedLocation = point;
                          placeName = "جارٍ تحديد الموقع...";
                        });
                      }
                      await _getPlaceName(point);
                      debugPrint(
                        "selectedLocation: $selectedLocation",
                      );
                      debugPrint("placeName after fetch: $placeName");  
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=mD3hxsomJ944qEmeFGUT",
                      userAgentPackageName: "com.example.app",
                    ),
                    if (selectedLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: selectedLocation!,
                            width: 50,
                            height: 50,
                            child: const Icon(
                              Icons.location_on,
                              size: 45,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                if (placeName != null)
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Theme.of(context).shadowColor.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (placeName == "جارٍ تحديد الموقع...")
                            const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          if (placeName == "جارٍ تحديد الموقع...")
                            const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              placeName!,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // زر التأكيد
                // Positioned(
                //   bottom: 20,
                //   left: 20,
                //   right: 20,
                //   child: CustomButton(
                //     width: double.infinity,
                //     height: 50.h,
                //     textstyle: TextStyles.font15WhiteColorW500,
                //     title: "Confirmation",
                //     onTap:
                //         (selectedLocation != null &&
                //             placeName != null &&
                //             placeName != "جارٍ تحديد الموقع...")
                //         ? () {
                //             Navigator.pop(context, {
                //               "lat": selectedLocation!.latitude,
                //               "lng": selectedLocation!.longitude,
                //               "name": placeName,
                //             });
                //           }
                //         : null,
                //   ),
                // ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed:
                        (selectedLocation != null &&
                            placeName != null &&
                            placeName != "جارٍ تحديد الموقع...")
                        ? () {
                            debugPrint("Button pressed!");
                            debugPrint("selectedLocation: $selectedLocation");
                            debugPrint("placeName: $placeName");
                            debugPrint("Sending back: $placeName"); // ← للتأكد
                            Navigator.pop(context, {
                              "lat": selectedLocation!.latitude,
                              "lng": selectedLocation!.longitude,
                              "name": placeName,
                            });
                          }
                        : null,
                    child: const Text("Confirmation"),
                  ),
                ),
              ],
            ),
    );
  }
}
