import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:funding/pages/inputpage.dart';
import 'package:funding/pages/verification_page.dart'; // Import the new VerificationPage
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
      'phone_number': fullPhoneNumber, // Save full phone number
      'area_code': _selectedAreaCode, // Save area code separately if needed
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
          padding: const EdgeInsets.all(8.0),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // This is the number inside the radio button
              Text(
                value,
                style: TextStyle(
                  color: _selectedGrade == value ? Colors.teal : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
        backgroundColor: Colors.teal, // Match the Homepage color
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[100], // Match the Homepage color
        child: ListView(
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
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
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Please enter your date of birth'),
            const SizedBox(height: 16),

            // Add Dropdowns for Day, Month, and Year
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDay,
                    decoration: const InputDecoration(
                      labelText: 'Day',
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
                    ),
                    items: List.generate(
                            100, (index) => DateTime.now().year - index)
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
            const SizedBox(height: 30),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }

                // Use the 'schools' variable imported from 'schools.dart'
                return schools.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              displayStringForOption: (String option) => option,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'School',
                    border: OutlineInputBorder(),
                    hintText: 'Search and select your school',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a school';
                    }
                    return null;
                  },
                );
              },
              onSelected: (String selectedSchool) {
                debugPrint('Selected school: $selectedSchool');
                _schoolController.text = selectedSchool;
              },
            ),
            const SizedBox(height: 30),
            // Add the grade selectors in one row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: Text("Grade")),
                _buildCustomRadioButton('10'),
                _buildCustomRadioButton('11'),
                _buildCustomRadioButton('12'),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Hides the password input
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () {
                      final phoneNumber =
                          '$_selectedAreaCode${_phoneNumberController.text.trim()}';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerificationPage(
                            phoneNumber: phoneNumber,
                            verifyServiceSid:
                                'VA6d981f03d1c375faee5e14a32eceaee3', // Pass the verifyServiceSid
                          ),
                        ),
                      ).then((isVerified) {
                        if (isVerified == true) {
                          _updateProfile(); // Proceed with updating the profile if verified
                        }
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _loading ? 'Saving...' : 'Save Changes',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
