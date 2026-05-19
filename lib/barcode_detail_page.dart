import 'dart:convert';
import 'package:flutter/material.dart';

class BarcodeDetailPage extends StatefulWidget {
  final String code;
  final dynamic data;

  const BarcodeDetailPage({super.key, required this.code, required this.data});

  @override
  State<BarcodeDetailPage> createState() => _BarcodeDetailPageState();
}

class _BarcodeDetailPageState extends State<BarcodeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Szczegóły: ${widget.code}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: _JsonView(data: widget.data),
        ),
      ),
    );
  }
}

class _JsonView extends StatelessWidget {
  final dynamic data;

  const _JsonView({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Text('Brak danych');
    }
    const encoder = JsonEncoder.withIndent('  ');
    final pretty = encoder.convert(data);
    return SelectableText(
      pretty,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
      ),
    );
  }
}
