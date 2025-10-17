import 'package:flutter/material.dart';

class CreativePaymentPage extends StatefulWidget {
  const CreativePaymentPage({super.key});

  @override
  State<CreativePaymentPage> createState() => _CreativePaymentPageState();
}

class _CreativePaymentPageState extends State<CreativePaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _editorController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedMethod = 'Credit Card';

  bool _isProcessing = false;

  final List<String> _paymentMethods = [
    'Credit Card',
    'PayPal',
    'Google Pay',
    'Bank Transfer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pay Editor", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white12,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              "Send Payment to Editor",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            /// Payment Form
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Editor Name"),
                    _buildTextFormField(
                      controller: _editorController,
                      hint: "Enter name",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Editor name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildLabel("Amount"),
                    _buildTextFormField(
                      controller: _amountController,
                      hint: "Enter amount",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Amount is required';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildLabel("Payment Method"),
                    _buildDropdown(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// Pay Now Button
            AbsorbPointer(
              absorbing: _isProcessing,
              child: GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus(); // Close keyboard

                  if (_formKey.currentState!.validate()) {
                    setState(() => _isProcessing = true);

                    await Future.delayed(const Duration(seconds: 2)); // Simulate payment

                    setState(() => _isProcessing = false);

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Payment Successful"),
                        content: Text(
                          "Payment of ₹${_amountController.text} sent to ${_editorController.text}.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.greenAccent, Colors.green],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: _isProcessing
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            "Pay Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Label Widget
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Input Field with Validation
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  /// Dropdown for Payment Method
  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedMethod,
      dropdownColor: Colors.grey[900],
      iconEnabledColor: Colors.white70,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: const TextStyle(color: Colors.white),
      items: _paymentMethods.map((method) {
        return DropdownMenuItem(
          value: method,
          child: Text(method),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedMethod = value!;
        });
      },
    );
  }
}
