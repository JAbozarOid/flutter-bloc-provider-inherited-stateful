class Contribution {
  final String author;
  final String category;
  final String moderator;
  final String repository;
  final String created;
  final String reviewDate;
  final String title;
  final double totalPayout;
  final String url;
  final String status;

  Contribution({
    this.author,
    this.category,
    this.moderator,
    this.repository,
    this.created,
    this.reviewDate,
    this.title,
    this.totalPayout,
    this.url,
    this.status,
  });

  Contribution.fromJson(Map json)
      : author = json['author'],
        category = (json['category'] as String)
            .replaceFirst('-task', '')
            .replaceFirst("task-", ''),
        moderator = json['moderator'],
        repository = (json['repository'] as String)
            .replaceFirst('https://github.com/', ''),
        title = json['title'],
        totalPayout = json['total_payout'] as double,
        url = json['url'],
        created = json['created'],
        reviewDate = json['review_date'],
        status = json['status'];
}

class GithubModel {
  final String tagName;
  final String htmlUrl;

  GithubModel(this.tagName, this.htmlUrl);

  GithubModel.fromJson(Map json)
      : this.tagName = json['tag_name'],
        this.htmlUrl = json['html_url'];
}
