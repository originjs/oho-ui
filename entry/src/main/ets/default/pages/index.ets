import { OhProgress, Style } from '../common/components/progress/OhProgress.ets'

@Entry
@Component
struct Index {
  @State value:number = 0
  @State indicatorSize: number = 50
  @State indicatorInset: number = 4
  @State indeterminate: boolean = true
  @State indicatorDirection: number = 1
  private colors: string[] = []
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
          indicatorDirection: this.indicatorDirection
        })
      }.margin(10)
      Column() {
        OhProgress({
          value: this.value,
          style: Style.Cir,
          layoutWidth: 200,
          layoutHeight: 100,
          indeterminate: this.indeterminate,
          indicatorDirection: this.indicatorDirection
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
        this.indicatorInset += 2
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