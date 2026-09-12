import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _descriptionController =
      TextEditingController(text: 'Groceries — Agora');
  final List<Map<String, dynamic>> _items = [
    {'name': 'Rice 5kg', 'price': '12', 'person': 'Tanvir'},
    {'name': 'Cooking oil', 'price': '8', 'person': 'Rafi'},
    {'name': 'Snacks', 'price': '6', 'person': 'Shared'},
  ];
  String _splitType = 'By item';

  XFile? _receiptImage;
  final ImagePicker _picker = ImagePicker();

  num get _totalAmount {
    return _items.fold(0, (sum, item) {
      final priceStr = item['price'].toString().replaceAll('\$', '');
      return sum + (num.tryParse(priceStr) ?? 0);
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _receiptImage = image;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _addItem(String name, String price, String person) {
    setState(() {
      _items.add({
        'name': name,
        'price': price,
        'person': person,
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _showAddItemDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final personController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price (\$)'),
            ),
            TextField(
              controller: personController,
              decoration: const InputDecoration(labelText: 'Assigned Person'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  priceController.text.isNotEmpty) {
                _addItem(
                  nameController.text,
                  priceController.text,
                  personController.text.isEmpty
                      ? 'Shared'
                      : personController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveExpense() async {
    if (_descriptionController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('expenses').add({
      'description': _descriptionController.text,
      'totalAmount': _totalAmount,
      'splitType': _splitType,
      'items': _items,
      'createdAt': FieldValue.serverTimestamp(),
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Expense',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Amount Display (Matching mockup)
              Center(
                child: Text(
                  '\$$_totalAmount',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Dashed Scan Receipt Button
              GestureDetector(
                onTap: _pickImage,
                child: CustomPaint(
                  painter: DashedBorderPainter(),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _receiptImage == null
                              ? Icons.camera_alt_outlined
                              : Icons.check_circle,
                          color: const Color(0xFFECA738),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _receiptImage == null
                              ? 'Scan Receipt'
                              : 'Receipt Selected ✓',
                          style: const TextStyle(
                            color: Color(0xFFECA738),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Description Input
              const Text(
                'DESCRIPTION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dynamic Items List Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ITEMS (from receipt)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showAddItemDialog,
                    child: const Text(
                      '+ Add Item',
                      style: TextStyle(
                        color: Color(0xFF0F382C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Added Items List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item['name']} — \$${item['price']}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              item['person'],
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => _removeItem(index),
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Split Type Selector (3 options: Equally, By item, %)
              const Text(
                'SPLIT TYPE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('Equally')),
                      selected: _splitType == 'Equally',
                      onSelected: (val) =>
                          setState(() => _splitType = 'Equally'),
                      selectedColor: const Color(0xFF0F382C),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: _splitType == 'Equally'
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('By item')),
                      selected: _splitType == 'By item',
                      onSelected: (val) =>
                          setState(() => _splitType = 'By item'),
                      selectedColor: const Color(0xFF0F382C),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: _splitType == 'By item'
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('%')),
                      selected: _splitType == '%',
                      onSelected: (val) => setState(() => _splitType = '%'),
                      selectedColor: const Color(0xFF0F382C),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color:
                            _splitType == '%' ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Save Button (Orange/Amber colored as in mockup)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFECA738),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Save Expense',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashed Border Painter for Scan Receipt Button
class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFECA738)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    double dashWidth = 6, dashSpace = 4, startX = 0;
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(25)));

    PathMetrics metrics = path.computeMetrics();
    for (PathMetric metric in metrics) {
      double length = metric.length;
      while (startX < length) {
        canvas.drawPath(
          metric.extractPath(startX, startX + dashWidth),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}