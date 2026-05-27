import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; 
import '../../domain/booking_cubit.dart';
import 'booking_summary_screen.dart';

class ScheduleVisitScreen extends StatefulWidget {
  const ScheduleVisitScreen({super.key});

  @override
  State<ScheduleVisitScreen> createState() => _ScheduleVisitScreenState();
}

class _ScheduleVisitScreenState extends State<ScheduleVisitScreen> {
  final List<DateTime> realDays = [];
  
  final List<String> morningSlots = ['08:00 AM', '09:30 AM', '11:00 AM'];
  final List<String> afternoonSlots = ['01:30 PM', '02:00 PM', '04:30 PM'];
  final List<String> eveningSlots = ['06:00 PM', '07:30 PM', '08:00 PM'];

  int selectedDayIndex = 0; 
  String selectedTime = '09:30 AM';

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      realDays.add(today.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();
    
    String currentMonthYear = DateFormat('MMMM yyyy').format(realDays[selectedDayIndex]);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      //  --- APP BAR ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF001A33), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Schedule Your Visit',
          style: TextStyle(color: Color(0xFF001A33), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        
      ),

      //  --- BODY  ---
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // --- HEADER SECTION ---
                  const Text(
                    'Step 2 of 3',
                    style: TextStyle(
                      color: Color(0xFF0052CC),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  
                  const SizedBox(height: 28),

                  // --- SELECTED SERVICE CARD ---
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Container(width: 5, height: 72, color: const Color(0xFF0052CC)),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: const Color(0xFFE6F0FA), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.medical_services_rounded, color: Color(0xFF0052CC), size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Selected Service', style: TextStyle(fontSize: 12, color: Color(0xFF667085))),
                              const SizedBox(height: 2),
                              Text(
                                cubit.confirmedService.isNotEmpty ? cubit.confirmedService : 'Wound Care', 
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF001A33)),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.check_circle_rounded, color: Color(0xFFCBD5E1), size: 22),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),


                  // --- SELECT DATE HEADER  ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Select Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
                      Text(currentMonthYear, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                    ],
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Choose the date and time that works best for your care visit.',
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  //  --- HORIZONTAL CALENDAR  ---
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: realDays.length,
                            itemBuilder: (context, index) {
                              final isSelected = index == selectedDayIndex;
                              final dayDateTime = realDays[index];
                              
                              String weekdayLetter = DateFormat('E').format(dayDateTime)[0]; 
                              String dayNumber = DateFormat('d').format(dayDateTime);

                              return GestureDetector(
                                onTap: () => setState(() => selectedDayIndex = index),
                                child: Container(
                                  width: 44,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF0052CC) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(weekdayLetter, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white70 : const Color(0xFF667085), fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 6),
                                      Text(dayNumber, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : const Color(0xFF001A33))),
                                      if (isSelected) ...[
                                        const SizedBox(height: 2),
                                        const CircleAvatar(radius: 2, backgroundColor: Colors.white),
                                      ]
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Color(0xFFF1F5F9), height: 1),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.info_outline_rounded, size: 16, color: Colors.green[700]),
                            const SizedBox(width: 8),
                            Text('Available slots are high this week.', style: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  //  --- AVAILABLE TIMES SECTION ---
                  const Text('Available Times', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
                  const SizedBox(height: 20),

                  _buildTimeSectionHeader(Icons.wb_sunny_outlined, 'Morning'),
                  const SizedBox(height: 10),
                  Wrap(spacing: 12, runSpacing: 12, children: morningSlots.map((time) => _buildTimeButton(time)).toList()),
                  const SizedBox(height: 24),

                  _buildTimeSectionHeader(Icons.wb_sunny_rounded, 'Afternoon'),
                  const SizedBox(height: 10),
                  Wrap(spacing: 12, runSpacing: 12, children: afternoonSlots.map((time) => _buildTimeButton(time)).toList()),
                  const SizedBox(height: 24),

                  _buildTimeSectionHeader(Icons.nightlight_round_outlined, 'Evening'),
                  const SizedBox(height: 10),
                  Wrap(spacing: 12, runSpacing: 12, children: eveningSlots.map((time) => _buildTimeButton(time)).toList()),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          //  --- BOTTOM BUTTON AREA ---
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0052CC),
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    String formattedRealDate = DateFormat('MMMM d, yyyy').format(realDays[selectedDayIndex]);
                    cubit.selectDateTime(formattedRealDate, selectedTime);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookingSummaryScreen()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next Step ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF667085)),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF667085), fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTimeButton(String time) {
    final isSelected = time == selectedTime;
    return InkWell(
      onTap: () => setState(() => selectedTime = time),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.27,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0052CC) : const Color(0xFFE6F0FA).withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? const Color(0xFF0052CC) : Colors.transparent),
        ),
        child: Text(
          time,
          style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF0052CC), fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
    );
  }
}