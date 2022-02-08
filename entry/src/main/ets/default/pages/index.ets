import router from '@system.router';

@Entry
@Component
struct Index {
  build() {
    Column({space: 5}) {
      Button('progressDem').onClick(() => {
        router.push({
          uri: 'pages/progressDem'
        })
      })
      Button('swiperLayout').onClick(() => {
        router.push({
          uri: 'pages/swiperLayoutDem'
        })
      })
      Button('sliderDem').onClick(() => {
        router.push({
          uri: 'pages/sliderDem'
        })
      })
      Button('switchDem').onClick(() => {
        router.push({
          uri: 'pages/switchDem'
        })
      })
    }
    .width('100%')
    .height('100%')
    .margin({top: 5})
  }
}
