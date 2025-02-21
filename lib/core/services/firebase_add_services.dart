import 'package:clothshop/features/profile/data/models/complaint_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAddServices {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addComplaint(ComplaintModel complaint) async {
    await _firestore.collection('complaints').add(complaint.toJson());
  }
}