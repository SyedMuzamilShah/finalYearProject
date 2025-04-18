import 'package:flutter/material.dart';
import 'contact_data.dart';
import 'contact_card.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> 
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String _filterStatus = 'All';
  String _filterLocation = 'All';
  late AnimationController _filterController;
  late Animation<double> _filterAnimation;

  @override
  void initState() {
    super.initState();
    _filterController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _filterAnimation = CurvedAnimation(
      parent: _filterController,
      curve: Curves.easeInOut,
    );
    _filterController.forward();
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredContacts = contacts.where((contact) {
      final matchesSearch = contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          contact.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          contact.position.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesStatus = _filterStatus == 'All' || 
          (_filterStatus == 'Active' && contact.status == 'Active') ||
          (_filterStatus == 'INSGENE' && contact.status == 'INSGENE');
      
      final matchesLocation = _filterLocation == 'All' || 
          contact.location.contains(_filterLocation);
      
      return matchesSearch && matchesStatus && matchesLocation;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: _filterAnimation,
            axisAlignment: -1,
            child: _buildFilterControls(),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1200) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildWideLayout(filteredContacts),
                  );
                } else if (constraints.maxWidth > 800) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildMediumLayout(filteredContacts),
                  );
                } else {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildNarrowLayout(filteredContacts),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: TextField(
              key: ValueKey(_searchQuery),
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: DropdownButton<String>(
                  key: ValueKey(_filterStatus),
                  value: _filterStatus,
                  items: ['All', 'Active', 'INSGENE'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _filterStatus = value!;
                    });
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: DropdownButton<String>(
                  key: ValueKey(_filterLocation),
                  value: _filterLocation,
                  items: [
                    'All',
                    'USA',
                    'Canada',
                    'New York',
                    'Montreal',
                    'Vancouver',
                    'Chicago',
                    'Calgary',
                    'Los Angeles',
                    'San Francisco',
                    'Houston',
                    'Miami',
                    'Manchester'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _filterLocation = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWideLayout(List<Contact> contacts) {
    return GridView.builder(
      key: const ValueKey('wide-layout'),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) => AnimatedContactCard(
        contact: contacts[index],
        index: index,
      ),
    );
  }

  Widget _buildMediumLayout(List<Contact> contacts) {
    return GridView.builder(
      key: const ValueKey('medium-layout'),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.0,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) => AnimatedContactCard(
        contact: contacts[index],
        index: index,
      ),
    );
  }

  Widget _buildNarrowLayout(List<Contact> contacts) {
    return ListView.builder(
      key: const ValueKey('narrow-layout'),
      padding: const EdgeInsets.all(16),
      itemCount: contacts.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: AnimatedContactCard(
          contact: contacts[index],
          index: index,
        ),
      ),
    );
  }
}