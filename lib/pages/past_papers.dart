import 'package:flutter/material.dart';
import 'package:funding/grades/grade10.dart';
import 'package:funding/grades/grade11.dart';
import 'package:funding/grades/grade12home.dart';
import 'package:funding/pages/landing_page.dart';

class PastPapers extends StatelessWidget {
  const PastPapers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );
          },
        ),
        title: const Text("GRADES"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              _buildCustomButton(
                label: 'Grade 12',
                icon: Icons.book,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Grade12HomePage()),
                  );
                },
              ),
              const SizedBox(height: 50),
              _buildCustomButton(
                label: 'Grade 11',
                icon: Icons.book,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Grade11Page()),
                  );
                },
              ),
              const SizedBox(height: 50),
              _buildCustomButton(
                label: 'Grade 10',
                icon: Icons.book,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Grade10Page()),
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Button Widget
  Widget _buildCustomButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
