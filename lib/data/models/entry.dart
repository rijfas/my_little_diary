class Entry {
  final String id;
  final String diaryId;
  final String title;
  final DateTime createdAt;
  final String data;
  const Entry({
    required this.id,
    required this.diaryId,
    required this.title,
    required this.createdAt,
    required this.data,
  });
}
