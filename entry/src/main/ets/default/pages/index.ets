import router from '@system.router';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Column({space: 30}){
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
        Button('stepper').onClick(() => {
          router.push({
            uri: 'pages/stepperDem'
          })
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}