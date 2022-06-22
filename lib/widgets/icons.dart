class MBSvgAssets {
  static final MBSvgAssets _instance = MBSvgAssets._internal();

  factory MBSvgAssets() {
    return _instance;
  }

  MBSvgAssets._internal();

  Map<AssetName, String> assets = {
    AssetName.search: "assets/icons/search.svg",
    AssetName.vectorBottom: "assets/icons/Vector.svg",
    AssetName.vectorTop: "assets/icons/Vector-1.svg",
    AssetName.headphone: "assets/icons/headphone.svg",
    AssetName.tape: "assets/icons/tape.svg",
    AssetName.vectorSmallBottom: "assets/icons/VectorSmallBottom.svg",
    AssetName.vectorSmallTop: "assets/icons/VectorSmallTop.svg",
    AssetName.back: "assets/icons/back.svg",
    AssetName.heart: "assets/icons/heart.svg",
    AssetName.discover: "assets/icons/discover.svg",
    AssetName.profile: "assets/icons/profile.svg",
  };
}

enum AssetName {
  search,
  vectorBottom,
  vectorTop,
  headphone,
  tape,
  vectorSmallBottom,
  vectorSmallTop,
  back,
  heart,
  chart,
  discover,
  profile
}
