/*import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BranchEmployeesScreen extends StatelessWidget {
  final String branch;

  const BranchEmployeesScreen({super.key, required this.branch});

  Future<List<Map<String, dynamic>>> _fetchEmployees() async {
    final response = await Supabase.instance.client
        .from('employee')
        .select()
        .eq('branch', branch);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$branch Employees List')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No employees found.'));
          }

          final employees = snapshot.data!;
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final emp = employees[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(emp['profile_picture'] ?? ''),
                ),
                title: Text(emp['name']),
                subtitle: Text('HRPN: ${emp['hrpn']} | Email: ${emp['email']}'),
              );
            },
          );
        },
      ),
    );
  }
}

*/
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'employee_detail_screen.dart'; // Make sure this screen exists

class BranchEmployeesScreen extends StatefulWidget {
  final String branch;

  const BranchEmployeesScreen({super.key, required this.branch});

  @override
  State<BranchEmployeesScreen> createState() => _BranchEmployeesScreenState();
}

class _BranchEmployeesScreenState extends State<BranchEmployeesScreen> {
  Future<List<Map<String, dynamic>>> _fetchEmployees() async {
    final response = await Supabase.instance.client
        .from('employee')
        .select()
        .eq('branch', widget.branch);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.branch} Employees List'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No employees found.'));
          }

          final employees = snapshot.data!;
          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final emp = employees[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EmployeeDetailScreen(employee: emp),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        emp['profile_picture'] ?? '',
                      ),
                      backgroundColor: Colors.grey[300],
                    ),
                    title: Text(
                      emp['name'] ?? 'No Name',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'HRPN: ${emp['hrpn']} | Email: ${emp['email']}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
