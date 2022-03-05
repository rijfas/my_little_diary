part of 'entry_cubit.dart';

abstract class EntryState {}

class EntryInitial extends EntryState {}

class EntryLoading extends EntryState {}

class EntryLoaded extends EntryState {
  EntryLoaded({required this.entries});
  final List<Entry> entries;
}
