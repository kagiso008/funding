import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:funding/pages/inputpage.dart';
import 'package:funding/pages/verification_page.dart';
import 'package:funding/main.dart';
import 'package:funding/lists/schools.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();

  String? _selectedAreaCode = '+27'; // Default area code
  String? _selectedDay;
  String? _selectedMonth;
  String? _selectedYear;
  String? _selectedGrade;
  String? _selectedSchool;
  var _loading = true;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession!.user.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      _firstNameController.text = (data['first_name'] ?? '') as String;
      _lastNameController.text = (data['last_name'] ?? '') as String;
      _phoneNumberController.text = (data['phone_number'] ?? '') as String;
      _passwordController.text = (data['password'] ?? '') as String;
      _schoolController.text = (data['school'] ?? '') as String;
      _selectedDay = (data['day'] ?? '01') as String;
      _selectedMonth = (data['month'] ?? '01') as String;
      _selectedYear = (data['year'] ?? '2000') as String;
      _selectedGrade = (data['grade'] ?? '10') as String;
    } on PostgrestException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final password = _passwordController.text.trim();
    final school = _schoolController.text.trim();

    // Combine day, month, and year into a full date string
    final dob =
        '$_selectedYear-$_selectedMonth-$_selectedDay'; // Use ISO format YYYY-MM-DD

    // Combine area code with the phone number
    final fullPhoneNumber = '$_selectedAreaCode$phoneNumber';

    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': fullPhoneNumber,
      'area_code': _selectedAreaCode,
      'password': password,
      'school': school,
      'grade': _selectedGrade,
      'date_of_birth': dob,
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted) context.showSnackBar('Successfully updated profile!');
    } on PostgrestException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EnterMarksPage()),
        );
      }
    }
  }

  Widget _buildCustomRadioButton(String value) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGrade = value;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _selectedGrade == value ? Colors.teal : Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            color: _selectedGrade == value
                ? Colors.teal.withOpacity(0.1)
                : Colors.white,
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: _selectedGrade == value ? Colors.teal : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[300]!, Colors.teal[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    value: _selectedAreaCode,
                    decoration: const InputDecoration(labelText: 'Area Code'),
                    items: const [
                      DropdownMenuItem(value: '+1', child: Text('+1')),
                      DropdownMenuItem(value: '+27', child: Text('+27')),
                      DropdownMenuItem(value: '+44', child: Text('+44')),
                      DropdownMenuItem(value: '+61', child: Text('+61')),
                      DropdownMenuItem(value: '+91', child: Text('+91')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedAreaCode = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Please enter your date of birth',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDay,
                    decoration: const InputDecoration(
                      labelText: 'Day',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: List.generate(31, (index) => index + 1)
                        .map((day) => DropdownMenuItem(
                              value: day.toString().padLeft(2, '0'),
                              child: Text(day.toString().padLeft(2, '0')),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDay = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedMonth,
                    decoration: const InputDecoration(
                      labelText: 'Month',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: List.generate(12, (index) => index + 1)
                        .map((month) => DropdownMenuItem(
                              value: month.toString().padLeft(2, '0'),
                              child: Text(month.toString().padLeft(2, '0')),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMonth = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedYear,
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: List.generate(100, (index) => 1920 + index)
                        .map((year) => DropdownMenuItem(
                              value: year.toString(),
                              child: Text(year.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Select your grade',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildCustomRadioButton('10'),
                _buildCustomRadioButton('11'),
                _buildCustomRadioButton('12'),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _schoolController,
              decoration: const InputDecoration(
                labelText: 'School',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
