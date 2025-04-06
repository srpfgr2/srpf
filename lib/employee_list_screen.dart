import 'package:flutter/material.dart';
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
