import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalculateApsNMUPage extends StatefulWidget {
  const CalculateApsNMUPage({super.key});

  @override
  _CalculateApsNMUPageState createState() => _CalculateApsNMUPageState();
}

class _CalculateApsNMUPageState extends State<CalculateApsNMUPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  bool isLoading = true;
  Map<String, int?> userMarks = {};
  double? aps;

  @override
  void initState() {
    super.initState();
    _fetchUserMarks();
  }

  Future<void> _fetchUserMarks() async {
    try {
      final response = await _supabaseClient
          .from('user_marks')
          .select(
              'math_mark, subject1_mark, subject2_mark, subject3_mark, subject4_mark, home_language_mark, first_additional_language_mark, second_additional_language_mark')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      setState(() {
        userMarks = {
          'math_mark': response['math_mark'],
          'subject1_mark': response['subject1_mark'],
          'subject2_mark': response['subject2_mark'],
          'subject3_mark': response['subject3_mark'],
          'subject4_mark': response['subject4_mark'],
          'home_language_mark': response['home_language_mark'],
          'first_additional_language_mark':
              response['first_additional_language_mark'],
          'second_additional_language_mark':
              response['second_additional_language_mark'],
        };
        aps = _calculateAps(userMarks);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user marks: $error')),
      );
    }
  }

  double _calculateAps(Map<String, int?> marks) {
    double apsScore = 0.0;

    // Collect all relevant marks
    final allMarks = [
      marks['math_mark'],
      marks['subject1_mark'],
      marks['subject2_mark'],
      marks['subject3_mark'],
      marks['subject4_mark'],
      marks['home_language_mark'],
      marks['first_additional_language_mark'],
      marks['second_additional_language_mark'],
    ];

    // Remove null values and divide each mark by 10
    final dividedMarks = allMarks
        .where((mark) => mark != null)
        .map((mark) => mark!.toDouble())
        .toList();

    // Sort marks in descending order
    dividedMarks.sort((a, b) => b.compareTo(a));

    // Take the best six marks
    final bestSixMarks = dividedMarks.take(6).toList();

    // Sum the best six marks to get the APS score
    apsScore =
        bestSixMarks.isNotEmpty ? bestSixMarks.reduce((a, b) => a + b) : 0.0;

    return apsScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YOUR APS AT NMU"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 240, 241, 241),
              Color.fromARGB(255, 230, 233, 232)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Text(
                                'Your APS Score',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                aps != null
                                    ? aps!.toStringAsFixed(
                                        1) // Ensure 1 decimal place
                                    : 'Error calculating APS',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Nelson Mandela University',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.tealAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                        ),
                        child: const Text(
                          'Go Back',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
