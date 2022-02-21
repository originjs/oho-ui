import { ohSlider } from 'oho-ui'

@Entry
@Component
struct SliderDem {
  @State value1: number  = 40
  @State value2: number  = 40
  @State value3: number  = 40
  @State value4: number  = 40
  @State value5: number  = 60
  @State value6: number  = 40
  @State value7: number  = 40
  @State value8: number  = 40
  @State rangeValue1: Array<number> = [20, 80]
  @State rangeValue2: Array<number> = [20, 80]

  private onChange(value) {
    console.info('当前值：' + value)
  }

  build() {
    Column() {
      Text('基础用法').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSlider({
        value: $value1,
        rangeValue: $rangeValue1,
        change: this.onChange
      })

      Text('双滑块').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSlider({
        value: $value2,
        rangeValue: $rangeValue1,
        range: true,
        change: this.onChange
      })

      Text('指定范围').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSlider({
        value: $value3,
        rangeValue: $rangeValue1,
        min: -50,
        max: 50,
        change: this.onChange
      })

      Text('禁用').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSlider({
        value: $value4,
        rangeValue: $rangeValue1,
        disabled: true,
      })

      Text('指定步长').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSlider({
        value: $value5,
        rangeValue: $rangeValue1,
        step: 10,
        change: this.onChange
      })

      Text('自定义样式').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      ohSlider({
        value: $value6,
        rangeValue: $rangeValue1,
        barHeight: 4,
        activeColor: '#ee0a24',
      })

      Text('垂直方向').fontSize(18).fontColor('#8f9ca2').width('90%').padding({top: 18, bottom: 14})

      Flex({justifyContent: FlexAlign.SpaceAround}) {
        ohSlider({
          value: $value7,
          rangeValue: $rangeValue1,
          vertical: true,
        })

        ohSlider({
          value: $value8,
          rangeValue: $rangeValue2,
          range: true,
          vertical: true,
        })
      }
    }.width('100%').margin({top: 5})
  }
}
