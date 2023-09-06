enum MessegeEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('git');

  const MessegeEnum(this.type);
  final String type;
}

extension ConvertMessege on String {
  MessegeEnum toEnum() {
    switch (this) {
      case 'audio':
        return MessegeEnum.audio;
      case 'image':
        return MessegeEnum.image;
      case 'text':
        return MessegeEnum.text;
      case 'gif':
        return MessegeEnum.gif;
      case 'video':
        return MessegeEnum.video;
      default:
        return MessegeEnum.text;
    }
  }

  
}
