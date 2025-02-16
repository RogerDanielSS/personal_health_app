
class EventEntity {
  final int id;
  final String title;
  final String column1;

  List get props => [id, title, column1];

  const EventEntity({
    required this.id,
    required this.title,
    required this.column1,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'column1': column1,
      };
}
