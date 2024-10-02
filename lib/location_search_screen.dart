import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'map_screen.dart'; // Import your MapScreen

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController currentLocationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  String statusMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Destination')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                try {
                  Position position = await _determinePosition();
                  currentLocationController.text = '${position.latitude}, ${position.longitude}';
                  setState(() {
                    statusMessage = 'Location retrieved successfully!';
                  });
                } catch (e) {
                  setState(() {
                    statusMessage = 'Error: ${e.toString()}';
                  });
                }
              },
              child: TextField(
                controller: currentLocationController,
                decoration: const InputDecoration(labelText: 'Current Location'),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(statusMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16.0),
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(labelText: 'Destination'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(
                      currentLocation: currentLocationController.text,
                      destination: destinationController.text,
                    ),
                  ),
                );
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  // Determine user's current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
