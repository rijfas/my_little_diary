part of 'search_entries_bloc.dart';

abstract class SearchEntriesState {}

class SearchEntriesInitial extends SearchEntriesState {}

class SearchEntriesLoading extends SearchEntriesState {}

class SearchEntriesLoaded extends SearchEntriesState {
  SearchEntriesLoaded({required this.entries});
  final List<Entry> entries;
}
