import { OhProgress, Style } from '../common/components/progress/OhProgress.ets'

@Entry
@Component
struct Index {
  @State value:number = 0
  @State indicatorSize: number = 50
  @State indicatorInset: number = 4
  @State indeterminate: boolean = true
  @State indicatorDirection: number = 1
  @State indicatorColor: string = '#6100ee'
  private colors: string[] = ['#f44336', '#9c27b0', '#2196f3', '#00bcd4', '#009688'
    , '#fffde7', '#ff5722', '#607d8b', '#4caf50', '#00bcd4', '#00bcd4']
  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Progress({value: this.value, style: ProgressStyle.Linear}).width(200).margin(10)
      Column() {
        OhProgress({
          value: this.value,
          style: Style.Line,
          layoutWidth: 200,
          layoutHeight: 50,
          indeterminate: this.indeterminate,
          indicatorDirection: this.indicatorDirection,
          trackThickness: this.indicatorInset + 2,
          indicatorInset: this.indicatorInset,
        })
      }.margin(10)
      Column() {
        OhProgress({
          value: this.value,
          style: Style.Cir,
          layoutWidth: 200,
          layoutHeight: 100,
          indeterminate: this.indeterminate,
          indicatorDirection: this.indicatorDirection,
          indicatorSize: this.indicatorSize,
          indicatorColor: this.indicatorColor
        })
      }.margin(10)
      Column() {
        Row() {
          Button('进度增加').onClick(() => {
            this.value += 20
          }).margin(10)
          Button('进度减少').onClick(() => {
            this.value -= 20
          })
        }
      }.margin(10)
      Column() {
        Row() {
          Button('变粗').onClick(() => {
            this.indicatorInset += 2
          }).margin(10)
          Button('变细').onClick(() => {
            this.indicatorInset -= 2
          }).margin(10)
          Button('变大').onClick(() => {
            this.indicatorSize += 10
          }).margin(10)
          Button('变小').onClick(() => {
            this.indicatorSize -= 10
          })
        }
      }.margin(10)
      Button('改变颜色').onClick(() => {
        const index = Number.parseInt(Math.random() * 10 as any)
        this.indicatorColor = this.colors[index]
      }).margin(10)
      Button('加载/停止').onClick(() => {
        this.indeterminate = !this.indeterminate
      }).margin(10)
      Button('顺时针/逆时针').onClick(() => {
        this.indicatorDirection = this.indicatorDirection === 0 ? 1 : 0
      }).margin(10)
    }
    .width('100%')
    .height('100%')
  }
}