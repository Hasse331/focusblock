class Link {
  final String name;
  final String link;

  Link({required this.name, required this.link});

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(name: json["name"] as String, link: json["link"] as String);
}
