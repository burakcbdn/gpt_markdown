import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeField extends StatefulWidget {
  const CodeField({super.key, required this.name, required this.codes});
  final String name;
  final String codes;

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  bool _copied = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onInverseSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text(widget.name),
              ),
              const Spacer(),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: widget.codes))
                      .then((value) {
                    setState(() {
                      _copied = true;
                    });
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() {
                    _copied = false;
                  });
                },
                icon: Icon(
                  (_copied) ? Icons.done : Icons.content_paste,
                  size: 15,
                ),
                label: Text((_copied) ? "Copied!" : "Copy code"),
              ),
            ],
          ),
          const Divider(
            height: 1,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.codes,
            ),
          ),
        ],
      ),
    );
  }
}