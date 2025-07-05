import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatelessWidget {
  final CollectionReference readings =
      FirebaseFirestore.instance.collection('solar_readings');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MPPT Solar Dashboard"),
        backgroundColor: Colors.green.shade700,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: readings.orderBy('timestamp', descending: true).limit(1).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Live Solar Data", style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 20),
                    _buildInfoTile("Voltage", "${data['voltage']} V"),
                    _buildInfoTile("Current", "${data['current']} A"),
                    _buildInfoTile("Power", "${data['power']} W"),
                    _buildInfoTile("Duty Cycle", "${(data['duty'] * 100).toStringAsFixed(1)}%"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: const TextStyle(fontSize: 16)),
    );
  }
}