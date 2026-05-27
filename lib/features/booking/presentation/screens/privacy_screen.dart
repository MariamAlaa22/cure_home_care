import 'package:flutter/material.dart';

class PrivacyInsuranceScreen extends StatelessWidget {
  const PrivacyInsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF001A33), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Privacy & Insurance', style: TextStyle(color: Color(0xFF001A33), fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Medical Data Privacy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: const Text(
                'Your health records and clinical summary inputs are fully encrypted under our security standards. Only authorized clinical nursing staff assigned to your home care can view your logs.',
                style: TextStyle(color: Color(0xFF475467), fontSize: 14, height: 1.4),
              ),
            ),
            const SizedBox(height: 28),
            const Text('Insurance Co-Pay', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_rounded, color: Colors.green, size: 20),
                      SizedBox(width: 10),
                      Text('AXA Insurance Connected', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your current plan covers up to 80% of nursing visit costs. Co-pay applies automatically during the booking summary steps.',
                    style: TextStyle(color: Color(0xFF475467), fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}