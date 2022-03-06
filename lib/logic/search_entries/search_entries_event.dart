part of 'search_entries_bloc.dart';

abstract class SearchEntriesEvent {}

class SearchCleared extends SearchEntriesEvent {}

class SearchStarted extends SearchEntriesEvent {
  SearchStarted({required this.query});
  final String query;
}
