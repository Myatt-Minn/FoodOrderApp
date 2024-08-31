class UnboardContent {
  String title;
  String descritpion;
  String image;

  UnboardContent(
      {required this.title, required this.descritpion, required this.image});
}

List<UnboardContent> contents = [
  UnboardContent(
      title: "Select from our\n      Best Menu",
      descritpion: "Pick our food from our menu\n       more than 55 times",
      image: "images/screen1.png"),
  UnboardContent(
      title: "Easy and Online\n         Payment",
      descritpion:
          "You can pay cash on develivery\n          or cart payment online",
      image: "images/screen2.png"),
  UnboardContent(
      title: "Quick delivery at\n         doorsteps",
      descritpion: "Deliver your food at your\n           Doorsteps",
      image: "images/screen3.png"),
];
