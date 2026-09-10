import 'package:cloud_firestore/cloud_firestore.dart';

class DisputeModel {
  final String id;
  final String title;
  final String reason;
  final String status; // 'Open' or 'Resolved'
  final String footerText;

  DisputeModel({
    required this.id,
    required this.title,
    required this.reason,
    required this.status,
    required this.footerText,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'reason': reason,
      'status': status,
      'footerText': footerText,
    };
  }

  factory DisputeModel.fromMap(String id, Map<String, dynamic> map) {
    return DisputeModel(
      id: id,
      title: map['title'] ?? '',
      reason: map['reason'] ?? '',
      status: map['status'] ?? 'Open',
      footerText: map['footerText'] ?? '',
    );
  }
}