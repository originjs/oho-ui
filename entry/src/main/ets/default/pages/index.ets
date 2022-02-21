import router from '@system.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Column({ space: 30 }) {
        Button('progressDem').onClick(() => {
          router.push({
            uri: 'pages/progressDem'
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
        Button('stepper').onClick(() => {
          router.push({
            uri: 'pages/stepperDem'
          })
        })
        Button('swiperLayout').onClick(() => {
          router.push({
            uri: 'pages/swiperLayoutDem'
          })
        })
      }
    }
    .width('100%')
    .height('100%')
    .margin({ top: 5 })
  }
}
