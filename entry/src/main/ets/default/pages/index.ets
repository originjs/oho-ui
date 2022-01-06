import router from '@system.router';

@Entry
@Component
struct Index {

  @State historyInput:string = '123'
  build() {
    Column() {
      Row({space: 30}){
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
      }
    }
    .width('100%')
    .height('100%')
  }
}