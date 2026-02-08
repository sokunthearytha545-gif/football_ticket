import 'package:flutter/material.dart';
import 'package:football_ticket/model/match_model.dart';
import 'package:football_ticket/page/main/home/payment_page.dart';

// ignore: must_be_immutable
class BuyTicketPage extends StatefulWidget {
  MatchModel match;
  BuyTicketPage({super.key, required this.match});

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  String selectedTicketType = 'VIP';
  int ticketQuantity = 1;

  Map<String, double> get ticketPrices {
    return {
      'VIP': widget.match.ticketVipPrice.toDouble(),
      'Regular': widget.match.ticketPrice.toDouble(),
    };
  }

  double get totalPrice {
    return ticketPrices[selectedTicketType]! * ticketQuantity;
  }

  void incrementQuantity() {
    setState(() {
      if (ticketQuantity < 10) {
        ticketQuantity++;
      }
    });
  }

  void decrementQuantity() {
    setState(() {
      if (ticketQuantity > 1) {
        ticketQuantity--;
      }
    });
  }

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
          'Buy Ticket',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              'Select ticket type',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            _buildTicketOption(
              type: 'VIP',
              price: widget.match.ticketVipPrice.toDouble(),
              iconColor: const Color(0xFF4CAF50),
              isSelected: selectedTicketType == 'VIP',
            ),

            const SizedBox(height: 16),

            _buildTicketOption(
              type: 'Regular',
              price: widget.match.ticketPrice.toDouble(),
              iconColor: const Color(0xFFFDB747),
              isSelected: selectedTicketType == 'Regular',
            ),

            const SizedBox(height: 40),

            const Text(
              'Number of tickets',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDB747),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.black87,
                        size: 24,
                      ),
                      onPressed: decrementQuantity,
                    ),
                  ),

                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      '$ticketQuantity',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDB747),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black87,
                        size: 24,
                      ),
                      onPressed: incrementQuantity,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Price: ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),

            const Spacer(),

            Center(
              child: SizedBox(
                width: 240,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Payment Confirmation'),
                        content: Text(
                          'You are buying $ticketQuantity $selectedTicketType ticket(s)\nTotal: \$${totalPrice.toStringAsFixed(2)}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentPage(
                                    dateTime:
                                        "${widget.match.date} | ${widget.match.time}",
                                    totalPrice: totalPrice,
                                    qty: ticketQuantity,
                                    ticketPrice:
                                        ticketPrices[selectedTicketType]!,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
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
                    'Pay Now',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketOption({
    required String type,
    required double price,
    required Color iconColor,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTicketType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? iconColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),

            Text(
              type,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const Spacer(),

            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
