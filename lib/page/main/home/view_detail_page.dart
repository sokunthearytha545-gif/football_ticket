import 'package:flutter/material.dart';
import 'package:football_ticket/model/match_model.dart';
import 'package:football_ticket/page/main/home/buy_ticket_page.dart';

// ignore: must_be_immutable
class ViewDetailPage extends StatefulWidget {
  MatchModel match;
  ViewDetailPage({super.key, required this.match});
  @override
  State<ViewDetailPage> createState() => _ViewDetailPageState();
}

class _ViewDetailPageState extends State<ViewDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'View Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF8B4513), const Color(0xFFA0522D)],
            ),
          ),
        ),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1589487391730-58f20eb2c308?w=800',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3),
                              BlendMode.darken,
                            ),
                            onError: (exception, stackTrace) {},
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.red.withOpacity(0.5),
                              Colors.transparent,
                              Colors.blue.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.red.shade700,

                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/${widget.match.team1}.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Text(
                                'VS',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade700,

                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/${widget.match.team2}.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                widget.match.team1VsTeam2,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              _buildDetailRow(
                icon: Icons.location_on,
                iconColor: const Color(0xFF4CAF50),
                text: widget.match.location,
              ),
              _buildDivider(),

              _buildDetailRow(
                icon: Icons.calendar_today,
                iconColor: const Color(0xFF4CAF50),
                text: widget.match.date,
              ),
              _buildDivider(),

              _buildDetailRow(
                icon: Icons.access_time,
                iconColor: const Color(0xFF4CAF50),
                text: widget.match.time,
              ),
              _buildDivider(),

              _buildDetailRow(
                icon: Icons.confirmation_number,
                iconColor: const Color(0xFF4CAF50),
                text: 'Ticket Price : \$${widget.match.ticketPrice}',
              ),
              _buildDivider(),

              _buildDetailRow(
                icon: Icons.confirmation_number,
                iconColor: const Color(0xFF4CAF50),
                text: 'Available Ticket : ${widget.match.availableTicket}',
              ),

              const SizedBox(height: 40),

              Center(
                child: SizedBox(
                  width: 220,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text('Proceeding to buy ticket...'),
                      //     backgroundColor: Colors.green,
                      //   ),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyTicketPage(
                             match: widget.match,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDB747),
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 4,
                      shadowColor: Colors.orange.withOpacity(0.5),
                    ),
                    child: const Text(
                      'Buy Ticket',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 56.0),
      child: Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
    );
  }
}
