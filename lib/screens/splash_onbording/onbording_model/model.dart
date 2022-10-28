class OnbordingContent {
  String image;
  String title;
  String description;

  OnbordingContent({
    required this.image, required this.title, required this.description
  });
}
List<OnbordingContent> contents = [
  OnbordingContent(image: "assets/images/karolina-stick.jpg", title: "Welcome to Fruit Hub",
      description: "The first avant-garde  minimalistic app to scientifically reinvent yourself one day at a time :)"),
  OnbordingContent(image: "assets/images/saladd.jpg", title: "Simplistic and Intutive",
      description: "Life is hard as it is, so this app is designed to keep your progress as simple and intutive as possible to assist and grow your mini habits. "),
  OnbordingContent(image: "assets/images/fruitMix.jpg", title: "Practical and Scientific",
      description: "A habit building approach that has been scientifically proven to build long lasting positive development that sticks to your brain like superghlue.")
];
