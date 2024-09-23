import 'package:flutter/material.dart';
import 'package:funding/pages/login_page.dart'; // Assuming you have a login page
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:funding/grades/grade12.dart';
import 'package:funding/grades/grade12IEB.dart';
import 'package:funding/pages/past_papers.dart';

class Grade12HomePage extends StatelessWidget {
  const Grade12HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PastPapers()),
            );
          },
        ),
        title: const Text("GRADE 12 Curriculums"),
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
              const SizedBox(height: 30),

              // Button to View National Senior Certificate
              _buildCustomButton(
                label: 'National Senior Certificate',
                icon: Icons.school_outlined,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Grade12Page()),
                  );
                },
              ),

              const SizedBox(height: 50),

              // Button to View Independent Examination Board
              _buildCustomButton(
                label: 'Independent Examination Board',
                icon: Icons.school_outlined,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Grade12IEBPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sign out method
  Future<void> _signOut(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut(); // Sign out from Supabase
      // Navigate to login page after successful sign out
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
