class Suggestion {
  final String title;
  final DateTime date;
  final String user;
  final String description;
  final String id;
  final int upvote;
  final List<String> tags;
  Suggestion(
      {required this.title,
      required this.upvote,
      required this.tags,
      required this.date,
      required this.user,
      required this.id,
      required this.description});
}

List<Suggestion> demoSuggestions = [
  Suggestion(
    id: '1',
    title: 'Add a new feature',
    date: DateTime(2022, 02, 10),
    user: 'John Doe',
    description:
        'I suggest adding a new feature that allows users to save their progress and resume later.',
    upvote: 20,
    tags: ["Hello", "jo"],
  ),
  Suggestion(
    id: '2',
    title: 'Add a new feature',
    date: DateTime(2022, 02, 10),
    user: 'John Doe',
    description:
        'I suggest adding a new feature that allows users to save their progress and resume later.',
    upvote: 20,
    tags: ["Hello", "jo"],
  ),
  Suggestion(
    id: '3',
    title: 'Add a new feature',
    date: DateTime(2022, 02, 10),
    user: 'John Doe',
    description:
        'I suggest adding a new feature that allows users to save their progress and resume later.',
    upvote: 20,
    tags: ["Hello", "jo"],
  ),
];
