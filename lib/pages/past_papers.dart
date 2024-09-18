import 'package:flutter/material.dart';
import 'package:funding/grades/grade10.dart';
import 'package:funding/grades/grade11.dart';
import 'package:funding/grades/grade12.dart';

class PastPapers extends StatelessWidget {
  const PastPapers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header text
              const Text(
                'GRADES',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              const SizedBox(height: 50),
              _buildCustomButton(
                label: 'Grade 12',
                icon: Icons.book,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Grade12Page()),
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
                    MaterialPageRoute(builder: (context) => Grade11Page()),
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
                    MaterialPageRoute(builder: (context) => Grade10Page()),
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
