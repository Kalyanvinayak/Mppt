class SolarData {
  final double voltage;
  final double current;
  final double power;
  final double duty;

  SolarData({
    required this.voltage,
    required this.current,
    required this.power,
    required this.duty,
  });

  factory SolarData.fromMap(Map<String, dynamic> map) {
    return SolarData(
      voltage: (map['voltage'] ?? 0).toDouble(),
      current: (map['current'] ?? 0).toDouble(),
      power: (map['power'] ?? 0).toDouble(),
      duty: (map['duty'] ?? 0).toDouble(),
    );
  }
}