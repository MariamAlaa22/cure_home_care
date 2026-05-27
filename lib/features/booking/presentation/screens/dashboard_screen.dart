import 'package:cure_home_care/features/booking/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/auth_cubit.dart';
import '../../../auth/domain/auth_state.dart';
import '../../domain/booking_cubit.dart';
import '../../domain/booking_state.dart';
import 'select_service_screen.dart';
import 'schedule_visit_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0; 

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    String userName = 'Patient'; 

    if (authCubit.state is AuthSuccess) {
      final msg = (authCubit.state as AuthSuccess).message;
      
      List<String> words = msg.split(' ');
      
      String userEmail = words.firstWhere(
        (word) => word.contains('@'), 
        orElse: () => '',
      );

      if (userEmail.isNotEmpty) {
        userName = userEmail.split('@').first;
      } else {
        userName = words.last;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: _currentIndex == 0
            ? _buildDashboardHome(context, userName) 
            : _buildPlaceholderScreen(_currentIndex),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectServiceScreen(),
              ),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: const Color(0xFF0052CC),
        unselectedItemColor: const Color(0xFF667085),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Body Dashboard
  Widget _buildDashboardHome(BuildContext context, String userName) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- APP HEADER ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.local_hospital_outlined,
                    color: Color(0xFF0052CC),
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  const Text(
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
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE6F0FA),
                child: Icon(
                  Icons.person_rounded,
                  color: Color(0xFF0052CC),
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // --- DYNAMIC WELCOME TEXT ---
          Text(
            'Hello, $userName ',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001A33),
            ),
          ),
          
          const SizedBox(height: 24),

          // --- NEXT APPOINTMENT CARD ---
          BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              final cubit = context.read<BookingCubit>();

              if (!cubit.hasActiveBooking) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FAFC),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.calendar_today_rounded, 
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'No upcoming visits',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'NEXT APPOINTMENT',
                          style: TextStyle(
                            color: Color(0xFF0052CC),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F0FA),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Text(
                            'Confirmed',
                            style: TextStyle(
                              color: Color(0xFF0052CC),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      cubit.confirmedService,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001A33),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: Color(0xFF667085),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Today, ${cubit.confirmedTime}',
                          style: const TextStyle(
                            color: Color(0xFF667085),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFFF0F4F8),
                          child: Icon(
                            Icons.medical_services,
                            size: 16,
                            color: Color(0xFF0052CC),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assigned Nurse',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF001A33),
                              ),
                            ),
                            Text(
                              'Registered Nurse (RN)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF667085),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          // --- NEED CARE CARD ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0052CC), Color(0xFF003D99)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Need Care?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Book an urgent or scheduled nursing visit.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0052CC),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectServiceScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Book Now',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // --- RECENT HISTORY ---
          const Text(
            'Recent History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001A33),
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              _buildHistoryRow(
                'Physiotherapy Session',
                'May 12, 2026 • 10:00 AM',
              ),
              _buildHistoryRow(
                'Medication Management',
                'May 10, 2026 • 04:15 PM',
              ),
            ],
          ),
          const SizedBox(height: 32),

          // --- MOST REQUESTED SERVICES ---
          const Text(
            'Most Requested Services',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001A33),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
            children: [
              _buildServiceShortcut(
                context,
                'Wound Care',
                Icons.healing_rounded,
                'Dressing & monitoring',
              ),
              _buildServiceShortcut(
                context,
                'General Nursing ',
                Icons.medical_services_rounded,
                'General assistance',
              ),
              _buildServiceShortcut(
                context,
                'Elderly Care',
                Icons.elderly_rounded,
                'Specialized support',
              ),
              _buildServiceShortcut(
                context,
                'Physiotherapy',
                Icons.accessibility_new_rounded,
                'Rehabilitation',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceShortcut(
    BuildContext context,
    String title,
    IconData icon,
    String subtitle,
  ) {
    return InkWell(
      onTap: () {
        context.read<BookingCubit>().selectService(title);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScheduleVisitScreen()),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFE6F0FA),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF0052CC), size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF001A33),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: Color(0xFF667085)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryRow(String title, String dateTime) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE6F4EA),
          child: Icon(Icons.check_circle_rounded, color: Color(0xFF137333)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(dateTime, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

Widget _buildPlaceholderScreen(int index) {
    if (index == 2) {
      return const ProfileScreen(); 
    }
    
    final titles = ['Home', 'My Bookings List', 'Patient Profile'];
    return Center(
      child: Text(
        titles[index],
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF001A33),
        ),
      ),
    );
  }
}