class UpdateMealCheckInParams {
  final String dietPlanMealId;
  final String date;
  final String status;
  final String? note;

  const UpdateMealCheckInParams({
    required this.dietPlanMealId,
    required this.date,
    required this.status,
    this.note,
  });
}
