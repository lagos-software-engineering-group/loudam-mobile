import 'package:intl/intl.dart';
import 'package:map_view/map_view.dart';

class Incident {
  final String id, title, summary, authorName, authorPhotoUrl;
  final String details = """
Oh he decisively impression attachment friendship so if everything. Whose her enjoy chief new young. Felicity if ye required likewise so doubtful.
On so attention necessary at by provision otherwise existence direction. Unpleasing up announcing unpleasant themselves oh do on. Way advantage age led listening belonging supposing.
Lose away off why half led have near bed. At engage simple father of period others except. My giving do summer of though narrow marked at.""";
  final DateTime submittedAt;
  final Location location;
  final List<String> imageUrls;

  Incident({
    this.id,
    this.title,
    this.summary,
    this.authorName,
    this.authorPhotoUrl,
    this.submittedAt,
    this.location,
    this.imageUrls,
  });

  String get posted {
    var fmt = new DateFormat("MMM d yyyy");
    return fmt.format(this.submittedAt);
  }
}

final incidents = <Incident>[
  new Incident(
    id: "1",
    title: "Flooding in Ajah",
    summary: "This would be the summary of this incident",
    authorName: "Akinbiyi",
    authorPhotoUrl: "https://lh6.googleusercontent.com/-9gxH_R7f6lI/AAAAAAAAAAI/AAAAAAAABBE/Vuf96Xe6Phg/s96-c/photo.jpg",
    submittedAt: new DateTime.now(),
    location: new Location(6.462123, 3.596579),
    imageUrls: <String>["res/images/flood-1.jpg", "res/images/flood-2.jpg"],
  ),
  new Incident(
    id: "2",
    title: "Crater on Badagry Road",
    summary: "This would be the summary of this incident",
    authorName: "Olugbenga",
    authorPhotoUrl: "https://pbs.twimg.com/profile_images/311251929/Bug_normal.png",
    submittedAt: new DateTime.now(),
    location: new Location(6.5005, 3.0975),
    imageUrls: <String>["res/images/crater.jpg"],
  ),
  new Incident(
    id: "3",
    title: "Trailer overturned on Carter Bridge",
    summary: "This would be the summary of this incident",
    authorName: "Adetayo",
    authorPhotoUrl: "https://lh6.googleusercontent.com/-9gxH_R7f6lI/AAAAAAAAAAI/AAAAAAAABBE/Vuf96Xe6Phg/s96-c/photo.jpg",
    submittedAt: new DateTime.now(),
    location: new Location(6.4619, 3.3869),
    imageUrls: <String>["res/images/accident.jpg"],
  ),
  new Incident(
    id: "4",
    title: "Serious traffic at Lekki toll gate",
    summary: "This would be the summary of this incident",
    authorName: "Akinbiyi",
    authorPhotoUrl: "https://lh6.googleusercontent.com/-9gxH_R7f6lI/AAAAAAAAAAI/AAAAAAAABBE/Vuf96Xe6Phg/s96-c/photo.jpg",
    submittedAt: new DateTime.now(),
    location: new Location(6.4412, 3.418),
    imageUrls: <String>["res/images/tolls.jpg"],
  ),
  new Incident(
    id: "5",
    title: "Bad section on Ikorodu road",
    summary: "This would be the summary of this incident",
    authorName: "Olubodun",
    authorPhotoUrl: "https://pbs.twimg.com/profile_images/311251929/Bug_normal.png",
    submittedAt: new DateTime.now(),
    location: new Location(6.60848, 3.393761),
    imageUrls: <String>["res/images/roads.jpg"],
  ),
];
