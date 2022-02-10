import { OhStepper } from 'oho-ui'

@Entry
@Component
struct StepperDem {
  private onInput() {
    AlertDialog.show({
      message: '加载中...',
      autoCancel: true

    })
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Start }) {
      Column({ space: 20 }) {
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          Text('基础用法')
            .fontSize(16)
          OhStepper()
        }

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          Text('步长设置')
            .fontSize(16)
            .width('30%')
          OhStepper({ step: 2 })
        }

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          Text('限制输入范围')
            .fontSize(16)
            .width('30%')
          OhStepper({ min: 5, max: 10 })
        }

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          Text('限制输入整数')
            .fontSize(16)
            .width('30%')
          OhStepper({ integer: true })
        }

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          Text('自定义大小')
            .fontSize(16)
            .width('30%')
          OhStepper({ size: 40 })
        }

        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
          Text('异步变更')
            .fontSize(16)
            .width('30%')
          OhStepper({
            input: this.onInput.bind(this)
          })
        }
      }.margin({top: 50, right: 10, left: 10})
    }
    .width('100%')
    .height('100%')
  }
}
