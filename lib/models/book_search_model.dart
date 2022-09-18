class BooksSearchModel {
  String? title;
  String? subtitle;
  String? isbn13;
  String? price;
  String? image;
  String? url;

  BooksSearchModel(
      {this.title,
      this.subtitle,
      this.isbn13,
      this.price,
      this.image,
      this.url});

  factory BooksSearchModel.fromJson(Map<String, dynamic> json) => BooksSearchModel(
        title: json['title'],
        subtitle: json['subtitle'],
        isbn13: json['isbn13'],
        price: json['price'],
        image: json['image'],
        url: json['url'],
      );
}
