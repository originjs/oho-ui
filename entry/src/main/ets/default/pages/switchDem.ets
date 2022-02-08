import {ohSwitch} from 'oho-ui'

@Entry
@Component
struct SwitchDem {
  @State checked1: boolean = true
  @State checked2: boolean = true
  @State checked3: boolean = true
  @State checked4: boolean = true
  @State checked5: boolean = true
  @State checked6: boolean = true

  private onInput() {
    AlertDialog.show(
      {
        title: '标题',
        message: '是否切换开关',
        autoCancel: false,
        primaryButton: {
          value: '取消',
          action: () => {}
        },
        secondaryButton: {
          value: '确认',
          action: () => {
            this.checked6 = !this.checked6
          }
        },
      }
    )
  }

  build() {
    Column() {
      Text('基础用法').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSwitch({
        checked: $checked1,
      })

      Text('禁用状态').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSwitch({
        checked: $checked2,
        disabled: true,
      })

      Text('加载状态').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSwitch({
        checked: $checked3,
        loading: true,
      })

      Text('自定义大小').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSwitch({
        checked: $checked4,
        size: 24,
      })

      Text('自定义颜色').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSwitch({
        checked: $checked5,
        activeColor: '#ee0a24',
        inactiveColor: '#dcdee0',
      })

      Text('异步控制').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSwitch({
        checked: $checked6,
        input: this.onInput.bind(this)
      })
    }
    .width('100%')
  }
}
