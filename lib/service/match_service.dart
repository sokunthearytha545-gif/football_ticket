import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_ticket/model/match_model.dart';

class MatchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<MatchModel>> matchGet() {
    return _firestore
        .collection('events')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    // ignore: unnecessary_cast
                    MatchModel.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<void> addSampleMatches(List<MatchModel> matches) async {
    final firestore = FirebaseFirestore.instance;
    try {
      for (var match in matches) {
        final docRef = firestore.collection('events').doc();
        await docRef.set(match.toJson());

        log("Added match: ${match.team1VsTeam2} with ID: ${docRef.id}");
      }
    } catch (e) {
      log("Error adding matches: $e");
    }
  }

  Future<void> addSampleEvents() async {
    final firestore = FirebaseFirestore.instance;

    try {
      List<MatchModel> matches = [
        MatchModel(
          location: "Stadium A",
          date: "20 Feb 2026",
          time: "8:00 PM",
          ticketPrice: 25,
          ticketVipPrice: 50,
          availableTicket: 100,
          team1: "lecce",
          team2: "cagliari",
          team1VsTeam2: "Lecce vs Cagliari",
        ),
        MatchModel(
          location: "Stadium B",
          date: "21 Feb 2026",
          time: "9:00 PM",
          ticketPrice: 22,
          ticketVipPrice: 45,
          availableTicket: 90,
          team1: "mancity",
          team2: "liverpool",
          team1VsTeam2: "Manchester City vs Liverpool",
        ),
        MatchModel(
          location: "Stadium C",
          date: "22 Feb 2026",
          time: "7:30 PM",
          ticketPrice: 20,
          ticketVipPrice: 40,
          availableTicket: 85,
          team1: "bayern",
          team2: "borussia",
          team1VsTeam2: "Bayern Munich vs Borussia Dortmund",
        ),
        MatchModel(
          location: "Stadium D",
          date: "23 Feb 2026",
          time: "8:45 PM",
          ticketPrice: 23,
          ticketVipPrice: 48,
          availableTicket: 95,
          team1: "psg",
          team2: "arsenal",
          team1VsTeam2: "PSG vs Arsenal",
        ),
        MatchModel(
          location: "Stadium E",
          date: "24 Feb 2026",
          time: "9:00 PM",
          ticketPrice: 24,
          ticketVipPrice: 49,
          availableTicket: 110,
          team1: "intermilan",
          team2: "acmilan",
          team1VsTeam2: "Inter Milan vs AC Milan",
        ),
      ];

      for (var match in matches) {
        final docRef = firestore.collection('events').doc();
        await docRef.set(match.toJson());

        log("Added match: ${match.team1VsTeam2} with ID: ${docRef.id}");
      }

      log("All sample events added successfully");
    } catch (e) {
      log("Error adding matches: $e");
    }
  }
}
