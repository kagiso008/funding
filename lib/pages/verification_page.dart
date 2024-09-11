import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'inputpage.dart';

class VerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String verifyServiceSid;

  const VerificationPage({
    super.key,
    required this.phoneNumber,
    required this.verifyServiceSid,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with SingleTickerProviderStateMixin {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final String accountSid =
      'ACa523d65e4cabc47e378de16287a3110f'; // Replace with your Twilio Account SID
  final String authToken =
      '2c7e5170a09356bee018796d2723ac96'; // Replace with your Twilio Auth Token

  @override
  void initState() {
    super.initState();
    _sendVerificationCode();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isLoading = true;
    });

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}';
    final url = Uri.parse(
        'https://verify.twilio.com/v2/Services/${widget.verifyServiceSid}/Verifications');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': basicAuth,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'To': widget.phoneNumber,
        'Channel': 'sms',
      },
    );

    if (response.statusCode == 201) {
      _showSnackBar('Verification code sent!');
    } else {
      _showSnackBar('Failed to send verification code.', isError: true);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}';
    final url = Uri.parse(
        'https://verify.twilio.com/v2/Services/${widget.verifyServiceSid}/VerificationCheck');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': basicAuth,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'To': widget.phoneNumber,
        'Code': _codeController.text.trim(),
      },
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      _showSnackBar('Phone number verified!');

      // Navigate to the LandingPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EnterMarksPage()),
      );
    } else {
      _showSnackBar('Verification failed.', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Phone Verification'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter the verification code sent to your number',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildCodeInputField(),
                  const SizedBox(height: 20),
                  _buildVerifyButton(),
                  const SizedBox(height: 10),
                  _buildResendButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeInputField() {
    return TextFormField(
      controller: _codeController,
      decoration: InputDecoration(
        labelText: 'Verification Code',
        labelStyle: const TextStyle(color: Colors.teal),
        filled: true,
        fillColor: Colors.teal.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _buildVerifyButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _verifyCode,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      child: _isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              'Verify',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
    );
  }

  Widget _buildResendButton() {
    return TextButton(
      onPressed: _isLoading ? null : _sendVerificationCode,
      child: Text(
        'Resend Code',
        style: TextStyle(
          fontSize: 16,
          color: Colors.teal.shade400,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
