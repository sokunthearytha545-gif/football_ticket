class MatchModel {
  final String location;
  final String date;
  final String time;
  final int ticketPrice;
  final int ticketVipPrice;
  final int availableTicket;
  final String team1;
  final String team2;
  final String team1VsTeam2;
  

  MatchModel({
    required this.location,
    required this.date,
    required this.time,
    required this.ticketPrice,
    required this.ticketVipPrice,
    required this.availableTicket,
    required this.team1,
    required this.team2,
    required this.team1VsTeam2,
  });
  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      location: json['location'] ?? "",
      date: json['date'] ?? "",
      time: json['time'] ?? "",
      ticketPrice: json['ticket_price'] ?? 0,
      ticketVipPrice: json['ticket_vip_price'] ?? 0,
      availableTicket: json['available_ticket'] ?? 0,
      team1: json['team1'] ?? "",
      team2: json['team2'] ?? "",
      team1VsTeam2: json['team1_vs_team2'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'date': date,
      'time': time,
      'ticket_price': ticketPrice,
      'ticket_vip_price': ticketVipPrice,
      'available_ticket': availableTicket,
      'team1': team1,
      'team2': team2,
      'team1_vs_team2': team1VsTeam2,
    };
  }
}
