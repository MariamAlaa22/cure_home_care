import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/auth_cubit.dart';
import '../../../auth/domain/auth_state.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import 'privacy_screen.dart';
import 'support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String bloodType = 'A+';
  String weight = '65 kg';
  String height = '168 cm';

  void _showEditMedicalDialog() {
    final bloodController = TextEditingController(text: bloodType);
    final weightController = TextEditingController(text: weight);
    final heightController = TextEditingController(text: height);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Medical Info', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: bloodController, decoration: const InputDecoration(labelText: 'Blood Type')),
            TextField(controller: weightController, decoration: const InputDecoration(labelText: 'Weight')),
            TextField(controller: heightController, decoration: const InputDecoration(labelText: 'Height')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0052CC)),
            onPressed: () {
              setState(() {
                bloodType = bloodController.text;
                weight = weightController.text;
                height = heightController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    String userEmail = 'patient@example.com';
    String userName = 'Patient User';

    if (authCubit.state is AuthSuccess) {
      final msg = (authCubit.state as AuthSuccess).message;
      List<String> words = msg.split(' ');
      String foundEmail = words.firstWhere((word) => word.contains('@'), orElse: () => '');

      if (foundEmail.isNotEmpty) {
        userEmail = foundEmail;
        userName = foundEmail.split('@').first;
        if (userName.isNotEmpty) {
          userName = userName[0].toUpperCase() + userName.substring(1);
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(
              Icons.local_hospital_outlined,
              color: Color(0xFF0052CC),
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              'CureCare',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0052CC),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: Color(0xFF0052CC), size: 28),
            onPressed: _showEditMedicalDialog,
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFE6F0FA),
                    child: Icon(Icons.person_rounded, size: 55, color: Color(0xFF0052CC)),
                  ),
                  const SizedBox(height: 16),
                  Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
                  const SizedBox(height: 4),
                  Text(userEmail, style: const TextStyle(fontSize: 14, color: Color(0xFF667085))),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMedicalCard('Blood Type', bloodType, Icons.bloodtype_rounded, Colors.red[600]!),
                _buildMedicalCard('Weight', weight, Icons.scale_rounded, Colors.orange[700]!),
                _buildMedicalCard('Height', height, Icons.straighten_rounded, Colors.teal[600]!),
              ],
            ),
            const SizedBox(height: 32),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _buildProfileOption(
                    Icons.shield_outlined, 
                    'Privacy & Insurance',
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyInsuranceScreen())),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(color: Color(0xFFF1F5F9), height: 1),
                  ),
                  _buildProfileOption(
                    Icons.help_outline_rounded, 
                    'Help & Support',
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpSupportScreen())),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFE5E5)),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  child: Row(
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.red, size: 22),
                      SizedBox(width: 14),
                      Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFFDA4A4), size: 14),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF667085))),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0052CC), size: 22),
            const SizedBox(width: 14),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF001A33))),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFCBD5E1), size: 14),
          ],
        ),
      ),
    );
  }
}