import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/booking_cubit.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final TextEditingController _remarksController = TextEditingController();

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();

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
          'Booking Summary',
          style: TextStyle(
            color: Color(0xFF001A33), 
            fontWeight: FontWeight.bold, 
            fontSize: 18,
          ),
        ),
        
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Step 3 of 3',
                    style: TextStyle(
                      color: Color(0xFF0052CC), 
                      fontWeight: FontWeight.bold, 
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- APPOINTMENT CARD ---
                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 4, height: 45, color: const Color(0xFF0052CC)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Home Health Visit',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001A33)),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      cubit.confirmedService.isNotEmpty ? cubit.confirmedService : 'General Nursing',
                                      style: const TextStyle(fontSize: 14, color: Color(0xFF667085), fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: const Color(0xFFE6F4EA), borderRadius: BorderRadius.circular(100)),
                                child: const Text(
                                  'In-Home',
                                  style: TextStyle(color: Color(0xFF137333), fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: Color(0xFFF1F5F9), height: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today_rounded, color: Color(0xFF0052CC), size: 20),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Date', style: TextStyle(fontSize: 11, color: Color(0xFF667085))),
                                        const SizedBox(height: 2),
                                        Text(cubit.confirmedDate.isNotEmpty ? cubit.confirmedDate : 'Select Date', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded, color: Color(0xFF0052CC), size: 20),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Time', style: TextStyle(fontSize: 11, color: Color(0xFF667085))),
                                        const SizedBox(height: 2),
                                        Text(cubit.confirmedTime.isNotEmpty ? cubit.confirmedTime : 'Select Time', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  //  --- CLINICAL DETAILS SECTION ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.assignment_ind_outlined, color: Color(0xFF0052CC), size: 22),
                            SizedBox(width: 10),
                            Text('Clinical Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF001A33))),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('Clinical Remarks', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF344054))),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _remarksController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Describe current symptoms, medical history, or specific instructions for the nurse...',
                            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF98A2B3), height: 1.4),
                            contentPadding: const EdgeInsets.all(14),
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFD0D5DD))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0052CC))),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFFE6F0FA).withValues(alpha: 0.5), borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFF0052CC)),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Providing accurate clinical history helps our nursing staff prepare the necessary medical supplies for your specific case.',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF344054), height: 1.3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          //  --- BOTTOM CONFIRM BUTTON ---
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
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
                    cubit.confirmBooking(_remarksController.text);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Confirm Booking ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Modify Schedule', style: TextStyle(color: Color(0xFF667085), fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}