import 'package:flutter/material.dart';
import 'contact_data.dart';

class AnimatedContactCard extends StatefulWidget {
  final Contact contact;
  final int index;

  const AnimatedContactCard({
    super.key,
    required this.contact,
    required this.index,
  });

  @override
  State<AnimatedContactCard> createState() => _AnimatedContactCardState();
}

class _AnimatedContactCardState extends State<AnimatedContactCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.05 * widget.index, 
          0.3 + 0.05 * widget.index, 
          curve: Curves.easeOut,
        ),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovered ? 1.03 : _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: _buildCardContent(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardContent() {
    return Card(
      elevation: _isHovered ? 6 : 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.contact.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.contact.status == 'Active'
                        ? Colors.green[100]
                        : Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.contact.status,
                    style: TextStyle(
                      color: widget.contact.status == 'Active'
                          ? Colors.green[800]
                          : Colors.orange[800],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.contact.group.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                widget.contact.group,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
            if (widget.contact.position.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                widget.contact.position,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
            if (widget.contact.email.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.email, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.contact.email,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            if (widget.contact.location.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    widget.contact.location,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            if (widget.contact.phone.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.phone, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    widget.contact.phone,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
            if (widget.contact.birthday.isNotEmpty) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.cake, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    widget.contact.birthday,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}