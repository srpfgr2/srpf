import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text('$branch Employees')),
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
