/*import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeListScreen extends StatefulWidget {
  final String branch;

  const EmployeeListScreen({super.key, required this.branch});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final supabase = Supabase.instance.client;
  List<dynamic> employees = [];

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    final response = await supabase
        .from('employee')
        .select()
        .eq('branch', widget.branch);

    setState(() {
      employees = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.branch} Employees'),
        backgroundColor: Colors.teal,
      ),
      body:
          employees.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(employee['name']),
                    subtitle: Text('HRPN: ${employee['HRPN']}'),
                  );
                },
              ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'employee_detail_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  final String branch;

  const EmployeeListScreen({super.key, required this.branch});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final supabase = Supabase.instance.client;
  List<dynamic> employees = [];
  int? hoveredIndex;

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    final response = await supabase
        .from('employee')
        .select()
        .eq('branch', widget.branch);

    setState(() {
      employees = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.branch} Employees list'),
        backgroundColor: Colors.teal,
      ),
      body:
          employees.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  final isHovered = hoveredIndex == index;

                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = index),
                    onExit: (_) => setState(() => hoveredIndex = null),
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => EmployeeDetailScreen(employee: employee),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isHovered ? Colors.teal[50] : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:
                              isHovered
                                  ? [
                                    BoxShadow(
                                      color: Colors.teal.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              employee['profile_picture'] ?? '',
                            ),
                            backgroundColor: Colors.grey[300],
                          ),
                          title: Text(
                            employee['name'] ?? 'No Name',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('HRPN: ${employee['hrpn']}'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
