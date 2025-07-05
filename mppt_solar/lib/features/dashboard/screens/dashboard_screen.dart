import 'package:flutter/material.dart';
import 'package:flutter_mppt_app/core/models/solar_data_model.dart';
import 'package:flutter_mppt_app/core/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MPPT Solar Dashboard")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firebaseService.getLatestReading(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final solarData = SolarData.fromMap(data);

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text("Live Solar Data", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildTile("Voltage", "${solarData.voltage} V"),
                  _buildTile("Current", "${solarData.current} A"),
                  _buildTile("Power", "${solarData.power} W"),
                  _buildTile("Duty Cycle", "${(solarData.duty * 100).toStringAsFixed(1)}%"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTile(String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}