enum MessegeEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  const MessegeEnum(this.type);
  final String type;
}

extension ConvertMessege on String {
  MessegeEnum toEnum(){
    switch (this) {
      case 'text':
        return MessegeEnum.text;
      case 'image':
        return MessegeEnum.image;
      case 'audio':
        return MessegeEnum.audio;
      case 'video':
        return MessegeEnum.video;
      case 'gif':
        return MessegeEnum.gif;
      default:
        return MessegeEnum.text;
    }
  }

  
}
