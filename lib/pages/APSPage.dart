import 'package:flutter/material.dart';
import 'package:funding/aps_calculators/uj_aps_calculator.dart';
import 'package:funding/aps_calculators/up_aps.dart';
import 'package:funding/aps_calculators/Stellies_aps.dart';
import 'package:funding/aps_calculators/wits_aps.dart';
import 'package:funding/aps_calculators/ukzn_aps.dart';
import 'package:funding/aps_calculators/rhodes_aps.dart';
import 'package:funding/aps_calculators/nmu_aps.dart';
import 'package:funding/aps_calculators/cput_aps.dart';
import 'package:funding/aps_calculators/uwc_aps.dart';
import 'package:funding/aps_calculators/nwu_aps.dart';
import 'package:funding/aps_calculators/ufs_aps.dart';
import 'package:funding/aps_calculators/ul_aps.dart';
import 'package:funding/aps_calculators/tut_aps.dart';
import 'package:funding/aps_calculators/wsu_aps.dart';
import 'package:funding/aps_calculators/cut_aps.dart';
import 'package:funding/aps_calculators/zululand_aps.dart';
import 'package:funding/aps_calculators/dut_aps.dart';
import 'package:funding/aps_calculators/smu_aps.dart';
import 'package:funding/aps_calculators/sp_aps.dart';
import 'package:funding/aps_calculators/mut_aps.dart';
import 'package:funding/aps_calculators/uct_aps.dart';
import 'package:funding/aps_calculators/univen_aps.dart';
import 'package:funding/aps_calculators/ufh_aps.dart';
import 'package:funding/aps_calculators/vut_aps.dart';

class UniversityLandingPage extends StatelessWidget {
  const UniversityLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header text
                const Text(
                  'South African Universities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30),

                // University of Johannesburg button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Johannesburg',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsUPPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Pretoria',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsSPPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Sol Plaatje University',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsUFHPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of fort hare',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsVUTPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'vaal University of technology',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateMUTAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Mangosuthu University of Technology',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsUFSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of the Free State',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateAPSUCTPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Cape Town',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateUNIVENAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Venda',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateUZAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of zululand',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateCUTAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'central University of Technology',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsRhodesPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Rhodes',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateWSUAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'walter sisulu University',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateDUTAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Durban University of Technology',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsCPUTPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Cape Peninsula University of Technology',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateSMUAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Sefako Makgatho University',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsStelliesPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Stellenbosch University',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateTUTAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Tshwane University of Technology',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsUWCPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of the Western Cape',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateULAPSPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Limpopo',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsNMUPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Nelson Mandela University',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsNWUPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'North West University',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsWitsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of the Witwatersrand',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalculateApsUkznPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'University of Kwa-zulu Natal',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Back to Landing Page Button
                _buildCustomButton(
                  label: 'Back to Landing Page',
                  icon: Icons.arrow_back,
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Button for navigation
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
