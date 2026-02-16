import 'package:flutter/material.dart';
import 'package:football_ticket/model/match_model.dart';
import 'package:football_ticket/model/ticket_model.dart';
import 'package:football_ticket/page/helper/loading_dailog.dart';
import 'package:football_ticket/page/main/main_page.dart';
import 'package:football_ticket/service/auth_service.dart';
import 'package:football_ticket/service/tickets_service.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  final double totalPrice;
  final int qty;
  final double ticketPrice;
  final String dateTime;
  final String ticketType;
  MatchModel match;
  PaymentPage({
    super.key,
    required this.match,
    required this.totalPrice,
    required this.qty,
    required this.ticketPrice,
    required this.dateTime,
    required this.ticketType,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedBank = 'ABA Bank';
  final _formKey = GlobalKey<FormState>();
  final _accountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _transactionRefController = TextEditingController();

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _transactionRefController.dispose();
    super.dispose();
  }

  String? _validateAccountName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter account name';
    }
    if (value.length < 3) {
      return 'Account name must be at least 3 characters';
    }
    return null;
  }

  String? _validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter account number';
    }
    if (value.length < 8) {
      return 'Account number must be at least 8 digits';
    }
    return null;
  }

  String? _validateTransactionRef(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter transaction reference number';
    }
    if (value.length < 6) {
      return 'Transaction reference must be at least 6 characters';
    }
    return null;
  }

  final List<Map<String, dynamic>> banks = [
    {
      'name': 'ABA Bank',
      'color': const Color(0xFF006BA6),
      'textColor': Colors.white,
    },
    {
      'name': 'Wing Bank',
      'color': const Color(0xFFB4D12E),
      'textColor': Colors.white,
    },
    {
      'name': 'ACLEDA Bank',
      'color': const Color(0xFF1B3B6F),
      'textColor': Colors.white,
    },
  ];
  String generateBookingId() {
    final now = DateTime.now();

    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');

    return 'TK$day$month$year$hour$minute$second';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Payment',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Football Match',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.dateTime,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tickets: ${widget.ticketType} ${widget.qty} * \$${widget.ticketPrice}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Total: \$${widget.totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Select Payment Method',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...banks.map(
                        (bank) => _buildBankOption(
                          name: bank['name'],
                          backgroundColor: bank['color'],
                          textColor: bank['textColor'],
                          isSelected: selectedBank == bank['name'],
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Payment Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _buildInputField(
                        label: 'Account Name',
                        controller: _accountNameController,
                        validator: _validateAccountName,
                        hint: 'Enter account holder name',
                        keyboardType: TextInputType.name,
                      ),

                      const SizedBox(height: 16),

                      _buildInputField(
                        label: 'Account Number',
                        controller: _accountNumberController,
                        validator: _validateAccountNumber,
                        hint: 'Enter account number',
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 16),

                      _buildInputField(
                        label: 'Transaction Reference Number',
                        controller: _transactionRefController,
                        validator: _validateTransactionRef,
                        hint: 'Enter transaction reference',
                        keyboardType: TextInputType.text,
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 240,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text('Confirm Payment'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Football Match'),
                            const SizedBox(height: 8),
                            Text(
                              '${widget.qty} tickets × \$${widget.ticketPrice}',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Total: \$${widget.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text('Payment Method: $selectedBank'),
                            const SizedBox(height: 8),
                            Text('Account: ${_accountNameController.text}'),
                            Text('Acc No: ${_accountNumberController.text}'),
                            Text('Ref: ${_transactionRefController.text}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              LoadingDialog.show(
                                context,
                                message: 'Processing Payment...',
                              );
                              try {
                                TicketService().createTicket(
                                  userId: '${AuthService().currentUser?.uid}',
                                  ticket: TicketModel(
                                    bookingID: generateBookingId(),
                                    date: widget.match.date,
                                    team1: widget.match.team1,
                                    location: widget.match.location,
                                    qty: widget.qty,
                                    status: "Pending",
                                    team1VsTeam2: widget.match.team1VsTeam2,
                                    team2: widget.match.team2,
                                    ticketPrice: widget.ticketPrice,
                                    ticketType: widget.ticketType,
                                    time: widget.match.time,
                                    paymentMethod: selectedBank,
                                    accountName: _accountNameController.text,
                                    accountNumber:
                                        _accountNumberController.text,
                                    referenceNumber:
                                        _transactionRefController.text,
                                  ),
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Payment of \$${widget.totalPrice.toStringAsFixed(2)} via $selectedBank successful!',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                LoadingDialog.hide(context);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(),
                                  ),
                                  (route) => false,
                                );
                              } catch (e) {
                                LoadingDialog.hide(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Payment failed: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  }
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
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required String hint,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              errorStyle: const TextStyle(fontSize: 12, height: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBankOption({
    required String name,
    required Color backgroundColor,
    required Color textColor,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                selectedBank = name;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4CAF50)
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        name
                            .split(' ')[0]
                            .substring(
                              0,
                              name == 'ACLEDA Bank'
                                  ? 3
                                  : name.split(' ')[0].length,
                            ),
                        style: TextStyle(
                          color: textColor,
                          fontSize: name == 'Wing Bank' ? 10 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey.shade300,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
                  ),
                ],
              ),
            ),
          ),

          /// SHOW QR WHEN SELECTED
          if (isSelected)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Account: ", style: TextStyle(fontSize: 14)),
                      Text(
                        "012 345 678",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  name == "ABA Bank"
                      ? Image(
                          image: AssetImage("assets/qr/aba.png"),
                          width: 250,
                          height: 250,
                        )
                      : name == "ACLEDA Bank"
                      ? Image(
                          image: AssetImage("assets/qr/ac.png"),
                          width: 250,
                          height: 250,
                        )
                      : Image(
                          image: AssetImage("assets/qr/wing.png"),
                          width: 250,
                          height: 250,
                        ),
                  const SizedBox(height: 12),

                  const Text(
                    "Scan to Pay",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
