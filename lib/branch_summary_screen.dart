/*
1.1
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'branch_employees_screen.dart';

class BranchSummaryScreen extends StatefulWidget {
  const BranchSummaryScreen({super.key});

  @override
  State<BranchSummaryScreen> createState() => _BranchSummaryScreenState();
}

class _BranchSummaryScreenState extends State<BranchSummaryScreen> {
  final supabase = Supabase.instance.client;
  Map<String, int> branchCounts = {};
  final List<String> branches = [
    'HQ',
    'A COY',
    'B COY',
    'C COY',
    'D COY',
    'E COY',
    'F COY',
    'SAF',
    'MT',
    'WIRELESS',
    'OFFICE STAFF',
    'MEDICAL',
  ];

  @override
  void initState() {
    super.initState();
    fetchBranchCounts();
  }

  Future<void> fetchBranchCounts() async {
    Map<String, int> counts = {};
    for (String branch in branches) {
      final response = await supabase
          .from('employee')
          .select()
          .eq('branch', branch);
      counts[branch] = response.length;
    }

    setState(() {
      branchCounts = counts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees by Branch"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: branches.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Adjust based on screen size
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final branch = branches[index];
            final count = branchCounts[branch] ?? 0;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BranchEmployeesScreen(branch: branch),
                  ),
                );
              },
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.indigo.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_tree_outlined,
                        size: 36,
                        color: Colors.indigo.shade800,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        branch,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo.shade900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "$count Employees",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.indigo.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/

/*
1
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'branch_employees_screen.dart';

class BranchSummaryScreen extends StatefulWidget {
  const BranchSummaryScreen({super.key});

  @override
  State<BranchSummaryScreen> createState() => _BranchSummaryScreenState();
}

class _BranchSummaryScreenState extends State<BranchSummaryScreen> {
  final supabase = Supabase.instance.client;
  Map<String, int> branchCounts = {};
  final List<String> branches = [
    'HQ',
    'A COY',
    'B COY',
    'C COY',
    'D COY',
    'E COY',
    'F COY',
    'SAF',
    'MT',
    'WIRELESS',
    'OFFICE STAFF',
    'MEDICAL',
  ];

  @override
  void initState() {
    super.initState();
    fetchBranchCounts();
  }

  Future<void> fetchBranchCounts() async {
    Map<String, int> counts = {};
    for (String branch in branches) {
      final response = await supabase
          .from('employee')
          .select()
          .eq('branch', branch);
      counts[branch] = response.length;
    }

    setState(() {
      branchCounts = counts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employees by Branch")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children:
              branchCounts.entries.map((entry) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BranchEmployeesScreen(branch: entry.key),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${entry.value} Employees",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'branch_employees_screen.dart';

class BranchSummaryScreen extends StatefulWidget {
  const BranchSummaryScreen({super.key});

  @override
  State<BranchSummaryScreen> createState() => _BranchSummaryScreenState();
}

class _BranchSummaryScreenState extends State<BranchSummaryScreen> {
  final supabase = Supabase.instance.client;
  Map<String, int> branchCounts = {};
  final List<String> branches = [
    'HQ',
    'A COY',
    'B COY',
    'C COY',
    'D COY',
    'E COY',
    'F COY',
    'SAF',
    'MT',
    'WIRELESS',
    'OFFICE STAFF',
    'MEDICAL',
  ];

  final Map<String, bool> isHovered = {};

  @override
  void initState() {
    super.initState();
    fetchBranchCounts();
  }

  Future<void> fetchBranchCounts() async {
    Map<String, int> counts = {};
    for (String branch in branches) {
      final response = await supabase
          .from('employee')
          .select()
          .eq('branch', branch);
      counts[branch] = response.length;
      isHovered[branch] = false;
    }
    setState(() {
      branchCounts = counts;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   final crossAxisCount = (screenWidth ~/ 160).clamp(2, 6);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = (screenWidth ~/ 160).clamp(2, 6);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Branch Summary',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children:
              branchCounts.entries.map((entry) {
                final hovered = isHovered[entry.key] ?? false;

                return MouseRegion(
                  onEnter: (_) {
                    setState(() => isHovered[entry.key] = true);
                  },
                  onExit: (_) {
                    setState(() => isHovered[entry.key] = false);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BranchEmployeesScreen(branch: entry.key),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      transform:
                          Matrix4.identity()..scale(hovered ? 1.08 : 1.0),
                      decoration: BoxDecoration(
                        color:
                            hovered
                                ? (isDark
                                    ? Colors.indigo.shade700
                                    : Colors.indigo.shade100)
                                : (isDark
                                    ? Colors.indigo.shade900
                                    : Colors.indigo.shade50),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                hovered
                                    ? Colors.indigo.withOpacity(
                                      isDark ? 0.5 : 0.3,
                                    )
                                    : Colors.black12,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.account_tree_rounded,
                                size: 30,
                                color:
                                    isDark
                                        ? Colors.white
                                        : Colors.indigo.shade900,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                entry.key,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${entry.value} Employees',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
