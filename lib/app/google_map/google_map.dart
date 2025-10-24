import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' hide Location;
import 'package:location/location.dart';
import 'package:oyato_food/app/widgets/primary_button.dart';


class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({super.key});

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  GoogleMapController? mapController;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  LatLng? selectedLocation;
  LocationData? currentLocation;
  String? location;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Use a Web or unrestricted key for Places API
    googlePlace = GooglePlace("AIzaSyDwSBNYfoyyAX-7foRTUXEO1j8P0V0D2d4");
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Location location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      currentLocation = await location.getLocation();
      setState(() {
        // latitude = currentLocation!.longitude.toString();
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  void _autoCompleteSearch(String value) async {
    if (value.isEmpty) {
      setState(() => predictions = []);
      return;
    }

    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      debugPrint("Autocomplete Results: ${result.predictions!.length}");
      setState(() => predictions = result.predictions!);
    } else {
      debugPrint("Autocomplete request failed: ${result?.status ?? 'Unknown error'}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Autocomplete failed: ${result?.status ?? 'Unknown error'}")),
      );
    }
  }

  Future<void> _selectPlace(String placeId) async {
    final details = await googlePlace.details.get(placeId);

    if (details != null && details.result != null) {
     final  lat = details.result!.geometry!.location!.lat!;
     final lon = details.result!.geometry!.location!.lng!;
     final name = details.result!.name ?? "";
       // location= details.result!.name;

      setState(() {
        selectedLocation = LatLng(lat, lon);
        predictions = [];
        location = name;
        searchController.text = name;
      });

      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(selectedLocation!, 15),
      );

      // 👉 Send to backend here

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to get place details")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
              zoom: 14,
            ),
            myLocationEnabled: true,
            markers: {
              if (selectedLocation != null)
                Marker(
                  markerId: const MarkerId("selected"),
                  position: selectedLocation!,
                ),
            },
          ),
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(8),
                  child: TextField(
                    controller: searchController,
                    onChanged: _autoCompleteSearch,
                    decoration: InputDecoration(
                      hintText: "Search location",
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                  ),
                ),
                if (predictions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        final p = predictions[index];
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(p.description ?? ""),
                          onTap: () => _selectPlace(p.placeId!),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          // 📍 Selected address + confirm button
          Positioned(
            bottom: 30,
            left: 15,
            right: 15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const SizedBox(height: 10),
                PrimaryButton(title: "Confirm Location", onTap: selectedLocation == null ? (){
                  print("Empty");
                } : (){
                  Get.back(result: {
                    'lat': selectedLocation!.latitude.toString(),
                    'lon': selectedLocation!.longitude.toString(),
                    'location': location,
                  });
                },),
              ],
            ),
          ),
        ],
      ),

    );
  }
}