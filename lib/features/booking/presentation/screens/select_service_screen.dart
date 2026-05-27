import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/booking_cubit.dart';
import 'schedule_visit_screen.dart';

class SelectServiceScreen extends StatelessWidget {
  const SelectServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Wound Care',
        'desc': 'Specialized dressing changes, surgical site monitoring, and...',
        'icon': Icons.healing_rounded,
        'color': const Color(0xFF0052CC), 
        'bgColor': const Color(0xFFE6F0FA),
      },
      {
        'title': 'IV Therapy',
        'desc': 'Professional administration of intravenous medications,...',
        'icon': Icons.vaccines_rounded,
        'color': const Color(0xFF0052CC), 
        'bgColor': const Color(0xFFE6F0FA),
      },
      {
        'title': 'Post-Op Care',
        'desc': 'Comprehensive recovery support following surgical...',
        'icon': Icons.medical_services_rounded,
        'color': const Color(0xFF007A5E), 
        'bgColor': const Color(0xFFE6F4F0),
      },
      {
        'title': 'General Nursing',
        'desc': 'Health assessments, medication management, an...',
        'icon': Icons.assignment_ind_rounded,
        'color': const Color(0xFF007A5E), 
        'bgColor': const Color(0xFFE6F4F0),
      },
      {
        'title': 'Elderly Care',
        'desc': 'Specialized daily support and health monitoring for seniors.',
        'icon': Icons.elderly_rounded,
        'color': const Color(0xFF0052CC),
        'bgColor': const Color(0xFFE6F4F0),
      },
      {
        'title': 'Physiotherapy',
        'desc': 'Home-based physical therapy and rehabilitation sessions.',
        'icon': Icons.accessibility_new_rounded,
        'color': const Color(0xFF0052CC), 
        'bgColor': const Color(0xFFE6F0FA),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF001A33), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Service',
          style: TextStyle(color: Color(0xFF001A33), fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Step 1 of 3',
              style: TextStyle(color: Color(0xFF0052CC), fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 16),
            const Text(
              'How can we help today?',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF001A33)),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose the medical service you need to schedule for your care visit.',
              style: TextStyle(fontSize: 15, color: Color(0xFF475467), height: 1.3),
            ),
            const SizedBox(height: 28),
            
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final item = services[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    clipBehavior: Clip.antiAlias, 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.read<BookingCubit>().selectService(item['title']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScheduleVisitScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 84, 
                            color: item['color'],
                          ),
                          const SizedBox(width: 16),
                          
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: item['bgColor'],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(item['icon'], color: item['color'], size: 24),
                          ),
                          const SizedBox(width: 16),
                          
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF001A33)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['desc'],
                                    style: const TextStyle(fontSize: 13, color: Color(0xFF475467), height: 1.2),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}