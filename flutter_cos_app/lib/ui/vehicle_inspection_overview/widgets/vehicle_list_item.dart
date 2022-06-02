import 'package:flutter/material.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';

class VehicleListItem extends StatelessWidget {
  const VehicleListItem({
    Key? key,
    required this.index,
    required this.vehicle,
  }) : super(key: key);

  final int index;
  final Vehicle vehicle;

  Color _getColorFromStatus(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'in-progress':
        return Colors.blue;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconFromStatus(String status) {
    switch (status) {
      case 'completed':
        return Icons.no_crash;
      case 'in-progress':
        return Icons.electric_car;
      case 'failed':
        return Icons.minor_crash;
      default:
        return Icons.electric_car;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20),
      color: const Color.fromARGB(255, 241, 240, 240),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "tag_${vehicle.id}",
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.network(
                vehicle.photo,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.appSwatchOne,
                            strokeWidth: 2,
                          ),
                        );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${vehicle.make} ${vehicle.model}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.calendar_month,
                          size: 18,
                          color: AppColors.appTertiary,
                        ),
                      ),
                      TextSpan(
                        text: ' ${vehicle.date}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.appTertiary,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          _getIconFromStatus(vehicle.status),
                          size: 20,
                          color: AppColors.appTertiary,
                        ),
                      ),
                      TextSpan(
                        text: ' ${vehicle.status}',
                        style: TextStyle(
                          fontSize: 15,
                          color: _getColorFromStatus(vehicle.status),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
