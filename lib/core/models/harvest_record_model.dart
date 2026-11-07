/// Record of a completed harvest logged by the urban farmer.
class HarvestRecord {
  HarvestRecord({
    required this.id,
    required this.plantName,
    required this.weightGrams,
    required this.harvestDate,
    this.notes = '',
    this.estimatedSavingsRp = 0,
  });

  final String id;
  final String plantName;
  final int weightGrams;
  final DateTime harvestDate;
  final String notes;
  final int estimatedSavingsRp;

  String get formattedWeight =>
      weightGrams >= 1000
          ? '${(weightGrams / 1000).toStringAsFixed(1)} kg'
          : '$weightGrams gram';
}
