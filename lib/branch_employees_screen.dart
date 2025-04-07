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
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'employee_detail_screen.dart'; // Make sure this screen exists

// class BranchEmployeesScreen extends StatefulWidget {
//   final String branch;

//   const BranchEmployeesScreen({super.key, required this.branch});

//   @override
//   State<BranchEmployeesScreen> createState() => _BranchEmployeesScreenState();
// }

// class _BranchEmployeesScreenState extends State<BranchEmployeesScreen> {
//   late Future<List<Map<String, dynamic>>> _futureEmployees;
//   int? hoveredIndex;

//   @override
//   void initState() {
//     super.initState();
//     _futureEmployees = _fetchEmployees();
//   }

//   Future<List<Map<String, dynamic>>> _fetchEmployees() async {
//     final response = await Supabase.instance.client
//         .from('employee')
//         .select()
//         .eq('branch', widget.branch);
//     return List<Map<String, dynamic>>.from(response);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.branch} Employees List'),
//         backgroundColor:
//             Theme.of(context).appBarTheme.backgroundColor ?? Colors.teal,
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _futureEmployees,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No employees found.'));
//           }

//           final employees = snapshot.data!;
//           return ListView.builder(
//             itemCount: employees.length,
//             itemBuilder: (context, index) {
//               final emp = employees[index];
//               final isHovered = hoveredIndex == index;

//               return MouseRegion(
//                 onEnter: (_) => setState(() => hoveredIndex = index),
//                 onExit: (_) => setState(() => hoveredIndex = null),
//                 cursor: SystemMouseCursors.click,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => EmployeeDetailScreen(employee: emp),
//                       ),
//                     );
//                   },
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color:
//                           isHovered
//                               ? (isDark
//                                   ? Colors.teal.shade900
//                                   : Colors.teal.shade50)
//                               : Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow:
//                           isHovered
//                               ? [
//                                 BoxShadow(
//                                   color: Colors.teal.withOpacity(0.3),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ]
//                               : [],
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           emp['profile_picture'] ?? '',
//                         ),
//                         backgroundColor: Colors.grey[300],
//                       ),
//                       title: Text(
//                         emp['name'] ?? 'No Name',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                         'HRPN: ${emp['hrpn']} | Email: ${emp['email']}',
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'employee_detail_screen.dart'; // Make sure this exists

class BranchEmployeesScreen extends StatefulWidget {
  final String branch;

  const BranchEmployeesScreen({super.key, required this.branch});

  @override
  State<BranchEmployeesScreen> createState() => _BranchEmployeesScreenState();
}

class _BranchEmployeesScreenState extends State<BranchEmployeesScreen> {
  List<Map<String, dynamic>> allEmployees = [];
  List<Map<String, dynamic>> filteredEmployees = [];
  TextEditingController searchController = TextEditingController();
  int? hoveredIndex;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final response = await Supabase.instance.client
        .from('employee')
        .select()
        .eq('branch', widget.branch);

    setState(() {
      allEmployees = List<Map<String, dynamic>>.from(response);
      filteredEmployees = allEmployees;
    });
  }

  void _performSearch(String query) {
    final q = query.toLowerCase();
    final results =
        allEmployees.where((emp) {
          final name = (emp['name'] ?? '').toLowerCase();
          final hrpn =
              (emp['hrpn'] ?? '')
                  .toString()
                  .toLowerCase(); // ✅ Safe for int or string

          return name.contains(q) || hrpn.contains(q);
        }).toList();

    setState(() {
      filteredEmployees = results;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.branch} Employees List'),
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor ?? Colors.teal,
      ),
      body:
          allEmployees.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        _performSearch(value.trim());
                      },
                      decoration: InputDecoration(
                        hintText: 'Search by name or HRPN, then press Enter',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                        filteredEmployees.isEmpty
                            ? const Center(child: Text("No employees found."))
                            : ListView.builder(
                              itemCount: filteredEmployees.length,
                              itemBuilder: (context, index) {
                                final emp = filteredEmployees[index];
                                final isHovered = hoveredIndex == index;

                                return MouseRegion(
                                  onEnter:
                                      (_) =>
                                          setState(() => hoveredIndex = index),
                                  onExit:
                                      (_) =>
                                          setState(() => hoveredIndex = null),
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => EmployeeDetailScreen(
                                                employee: emp,
                                              ),
                                        ),
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isHovered
                                                ? (isDark
                                                    ? Colors.teal.shade900
                                                    : Colors.teal.shade50)
                                                : Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:
                                            isHovered
                                                ? [
                                                  BoxShadow(
                                                    color: Colors.teal
                                                        .withOpacity(0.3),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ]
                                                : [],
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
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'HRPN: ${emp['hrpn']} | Email: ${emp['email']}',
                                        ),
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
                  ),
                ],
              ),
    );
  }
}
