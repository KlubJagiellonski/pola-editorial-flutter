import 'dart:convert';
import 'package:flutter/material.dart';

import 'pola_api.dart';

class BarcodeDetailPage extends StatefulWidget {
  final String code;
  final dynamic data;

  const BarcodeDetailPage({super.key, required this.code, required this.data});

  @override
  State<BarcodeDetailPage> createState() => _BarcodeDetailPageState();
}

class _BarcodeDetailPageState extends State<BarcodeDetailPage> {
  final PolaApi _api = PolaApi();
  bool _isLoading = false;

  Future<void> _setIngredients(String ingredients) async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      await _api.setIngredients(widget.code, ingredients);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Zapisano pomyślnie!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Błąd zapisu: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Szczegóły: ${widget.code}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Surowce',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => _setIngredients('PL'),
                    child: _isLoading 
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) 
                        : const Text('Polskie'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => _setIngredients('NPL'),
                    child: _isLoading 
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) 
                        : const Text('Nie polskie'),
                  ),
                ],
              ),
              const Divider(height: 32),
              _JsonView(data: widget.data),
            ],
          ),
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
