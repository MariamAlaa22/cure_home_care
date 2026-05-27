import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
        title: const Text('Help & Support', style: TextStyle(color: Color(0xFF001A33), fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How can we help you?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
            const SizedBox(height: 6),
            const Text('Our support team is available 24/7 for patient emergency shifts.', style: TextStyle(color: Color(0xFF667085), fontSize: 14)),
            const SizedBox(height: 28),
            
            _buildSupportTile(Icons.call_rounded, 'Emergency Hotline', 'Call 19xxx for instant nursing care support.'),
            const SizedBox(height: 16),
            _buildSupportTile(Icons.mail_outline_rounded, 'Email Support', 'support@curecare.com'),
            const SizedBox(height: 16),
            _buildSupportTile(Icons.question_answer_outlined, 'Frequently Asked Questions', 'Read our nursing availability policies.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: const Color(0xFFE6F0FA), child: Icon(icon, color: const Color(0xFF0052CC))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF001A33))),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Color(0xFF667085), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}