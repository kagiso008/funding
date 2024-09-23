import 'package:flutter/material.dart';
import 'package:funding/pages/APSPage.dart';
import 'package:funding/pages/scholarshipsPage.dart';
import 'package:funding/pages/login_page.dart'; // Assuming you have a login page
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:funding/pages/analytics.dart';
import 'package:funding/pages/past_papers.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
                'Welcome to Reslocate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 30),

              // Button to View Scholarships
              _buildCustomButton(
                label: 'View Scholarships',
                icon: Icons.school_outlined,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
              ),

              const SizedBox(height: 50),
              _buildCustomButton(
                label: 'View Analytics',
                icon: Icons.school_outlined,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnalyticsPage()),
                  );
                },
              ),
              const SizedBox(height: 50),
              _buildCustomButton(
                label: 'calculate APS',
                icon: Icons.calculate,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UniversityLandingPage()),
                  );
                },
              ),
              const SizedBox(height: 50),
              _buildCustomButton(
                label: 'Past Papers',
                icon: Icons.calculate,
                color: Colors.teal,
                onPressed: () {
                  // Navigate to Homepage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PastPapers()),
                  );
                },
              ),
              const SizedBox(height: 50),

              // Button to Sign Out
              _buildCustomButton(
                label: 'Sign Out',
                icon: Icons.logout,
                color: Colors.redAccent,
                onPressed: () async {
                  await _signOut(context); // Call the _signOut method
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
