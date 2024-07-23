import 'package:flutter/material.dart';
import 'package:inventory_software/product_pg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedMonth = 'July';
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Overview Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOverviewCard('Total Sales', '₹1,20,000'),
                _buildOverviewCard('Outstanding Invoices', '₹50,000'),
                _buildOverviewCard('Expenses', '₹30,000'),
              ],
            ),
            const SizedBox(height: 20),
            // Recent Transactions
            Expanded(
              child: _buildRecentTransactions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value) {
    bool isTotalSales = title == 'Total Sales';
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isTotalSales) _buildMonthDropdown(),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthDropdown() {
    return Align(
      alignment: Alignment.topRight,
      child: DropdownButton<String>(
        value: selectedMonth,
        onChanged: (String? newValue) {
          setState(() {
            selectedMonth = newValue!;
          });
        },
        items: months.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.receipt),
          title: Text('Invoice #12345'),
          subtitle: Text('₹5,000 - Paid'),
          trailing: Text('25/07/2024'),
        ),
        ListTile(
          leading: Icon(Icons.receipt),
          title: Text('Invoice #12346'),
          subtitle: Text('₹7,000 - Pending'),
          trailing: Text('24/07/2024'),
        ),
        // Add more transactions
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Navigation'),
          ),
          const ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          const ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Invoices'),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Clients'),
          ),
          const ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Reports'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Product'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductPage()),
              );
            },
          ),
          // Add more navigation items
        ],
      ),
    );
  }
}
