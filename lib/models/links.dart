class Link {
  final String name;
  final Uri link;

  Link({required this.name, required this.link});

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(name: json["name"] as String, link: Uri.parse(json["link"]));

  Map<String, dynamic> toJson() => {
        'name': name,
        'link': link.toString(),
      };
}
