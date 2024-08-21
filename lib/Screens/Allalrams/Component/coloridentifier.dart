import '../../../config/import.dart';

class ColorIdentifier extends StatelessWidget {
  final service;
  final color;
  const ColorIdentifier({this.service, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              color: color.withOpacity(0.8),
            ),
            const SizedBox(width: 20.0),
            Expanded(child: Text(service))
          ],
        ),
      ),
    );
  }
}