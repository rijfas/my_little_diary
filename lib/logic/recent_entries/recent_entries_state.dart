part of 'recent_entries_cubit.dart';

abstract class RecentEntriesState {}

class RecentEntriesInitial extends RecentEntriesState {}

class RecentEntriesLoading extends RecentEntriesState {}

class RecentEntriesLoaded extends RecentEntriesState {
  final List<Entry> entries;
  RecentEntriesLoaded({required this.entries});
}
