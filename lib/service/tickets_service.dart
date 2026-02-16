import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_ticket/model/ticket_model.dart';

class TicketService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createTicket({
    required String userId,
    required TicketModel ticket,
  }) async {
    try {
      final docRef = _firestore
          .collection('tickets')
          .doc(userId)
          .collection('listTickets')
          .doc();

      final data = ticket.toJson();
      data['created_at'] = FieldValue.serverTimestamp();

      await docRef.set(data);
      log("Ticket created under user $userId with ID: ${docRef.id}");
    } catch (e) {
      log("Error creating ticket: $e");
    }
  }

  Stream<List<TicketModel>> ticketStream(String userId) {
    return _firestore
        .collection('tickets')
        .doc(userId)
        .collection('listTickets')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
          log(
            snapshot.docs.length > 0
                ? "Fetched ${snapshot.docs.length} tickets for user $userId"
                : "No tickets found for user $userId",
          );
          return snapshot.docs
              .map((doc) => TicketModel.fromJson(doc.data()))
              .toList();
        });
  }

  // Stream<List<TicketModel>> ticketStream(String userId) {
  //   return _firestore
  //       .collection('tickets')
  //       .doc(userId)
  //       .collection('listTickets')
  //       .snapshots()
  //       .map(
  //         (snapshot) => snapshot.docs
  //             .map(
  //               (doc) =>
  //                   // ignore: unnecessary_cast
  //                   TicketModel.fromJson(doc.data() as Map<String, dynamic>),
  //             )
  //             .toList(),
  //       );
  // }
}
