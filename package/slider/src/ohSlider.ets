import { Touch } from './touch'

@Component
export struct ohSlider {
  @Link value: number
  @Link rangeValue: Array<number>

  @State min: number = 0
  @State max: number = 100
  @State disabled: boolean = false
  @State step: number = 1
  @State range: boolean = false
  @State barHeight: number = 2
  @State activeColor: string = '#1989fa'
  @State buttonSize: number = 24
  @State buttonColor: string = '#fff'
  @State vertical: boolean = false

  @State sliderWidth: number = 800
  @State clickValue: number = 0
  @State startValue: number = 0
  @State startRangeValue: Array<number> = []
  @State buttonIdx: number = 0
  @State reverse: boolean = false
  @State dragStatus: string = ""

  private aboutToAppear(): void  {
    this.value = this.clamp(this.value)
    if (this.range) {
      this.rangeValue.map(this.clamp)
    }
  }

  private change

  private clamp = (num: number): number => {
    return Math.min(Math.max(num, this.min), this.max)
  }

  private touch = new Touch()

  private scoped(): number {
    return this.max - this.min
  }

  private calcMainAxis(): string {
    if (this.range) {
      const width = (this.rangeValue[1] - this.rangeValue[0]) * 100 / this.scoped()
      return `${width ? width : 0.001}%`
    } else {
      const width = (this.value - this.min) * 100 / this.scoped()
      return `${width ? width : 0.001}%`
    }
  }

  private opacityValue():number {
    return this.disabled ? 0.4 : 1
  }

  private format(value: number): number {
    value = this.clamp(value)
    const diff = Math.round((value - this.min) / this.step) * this.step
    return this.min + diff
  }

  private calcOffset(): string {
    if (this.range) {
      return `${(this.rangeValue[0] - this.min) * 100 / this.scoped()}%`
    }
    return '0%'
  }

  private handleRangeValue(value: number) {
    const left = value[0] ?? this.min
    const right = value[1] ?? this.max
    if (left > right) {
      this.reverse = !this.reverse
      return [right, left]
    } else {
      return [left, right]
    }
  }

  private updateValue(value) {
    if (this.range) {
      this.rangeValue = this.handleRangeValue(value).map(this.format.bind(this))
    } else {
      this.value = this.format(value)
    }
  }

  private buttonPosition(idx: 0 | 1): string {
    if (this.reverse) {
      return idx === 1 ? '0%' : '100%'
    } else {
      return !this.range || idx === 1 ? '100%' : '0%'
    }
  }

  private getPositionKey(): Array<string> {
    return this.vertical ? ['y', 'x'] : ['x', 'y']
  }

  private sliderWrapperWidth(): number | string {
    return this.vertical ? 18 : this.sliderWidth + 'px'
  }

  private sliderWrapperHeight(): number | string {
    return this.vertical ? this.sliderWidth + 'px' : 18
  }

  private sliderBarWidth(): number | string {
    return this.vertical ? this.barHeight : '100%'
  }

  private sliderBarHeight(): number | string {
    return this.vertical ? '100%' : this.barHeight
  }

  private sliderBarMargin() {
    const marginKey = this.vertical ? ['left', 'right'] : ['top', 'bottom']
    const margin = (18 - this.barHeight) / 2
    return {
      [marginKey[0]]: margin,
      [marginKey[1]]: margin,
    }
  }

  private activeBarWidth(): number | string {
    return this.vertical ? this.barHeight : this.calcMainAxis()
  }

  private activeBarHeight(): number | string {
    return this.vertical ? this.calcMainAxis() : this.barHeight
  }

  private activeBarPosition() {
    const positionKey = this.getPositionKey()
    return {
      [positionKey[0]]: this.calcOffset(),
      [positionKey[1]]: 0,
    }
  }

  private activeBarAnimation() {
    const animation = {
      duration: 0,
      curve: Curve.Ease,
    }
    if (!this.dragStatus) {
      animation.duration = 200
    }
    return animation
  }

  private sliderButtonMargin() {
    const marginKey = this.vertical ? 'top' : 'left'
    return {
      [marginKey]: -12
    }
  }

  private sliderButtonPosition(value) {
    const positionKey = this.getPositionKey()
    return {
      [positionKey[0]]: this.buttonPosition(value.idx),
      [positionKey[1]]: (this.barHeight - this.buttonSize) / 2,
    }
  }

  build() {
    Column() {
      Column() {
        Column() {
          ForEach(
            this.range ? this.rangeValue.map((item, idx) => ({item, idx})) : [this.value],
            (value) => {
              Button()
                .width(this.buttonSize)
                .height(this.buttonSize)
                .margin(this.sliderButtonMargin())
                .position(this.sliderButtonPosition(value))
                .backgroundColor(this.buttonColor)
                .border({width: 1, color: '#c4c4c4', radius: 12})
                .onTouch((event: TouchEvent) => {
                  if (this.disabled) return

                  if (event.type === TouchType.Down) {
                    this.dragStatus = 'starting'
                    this.touch.start(event)
                    if (this.range) {
                      this.buttonIdx = this.reverse ? 1- value.idx : value.idx
                      this.startRangeValue = Array.from(this.rangeValue)
                    } else {
                      this.startValue = this.format(this.value)
                    }
                  }

                  if (event.type === TouchType.Move) {
                    this.dragStatus = 'moving'
                    this.touch.move(event)
                    const delta = this.vertical ? this.touch.deltaY : this.touch.deltaX
                    const diff = delta / this.sliderWidth * this.scoped()
                    if (this.range) {
                      const current = []
                      current[this.buttonIdx] = this.startRangeValue[this.buttonIdx] + diff
                      current[1-this.buttonIdx] = this.startRangeValue[1-this.buttonIdx]
                      this.updateValue(current)
                    } else {
                      this.updateValue(this.startValue + diff)
                    }
                  }

                  if (event.type == TouchType.Up) {
                    this.dragStatus = ''
                    if (typeof this.change === 'function') {
                      if (this.range) {
                        this.change(this.rangeValue)
                      } else {
                        this.change(this.value)
                      }
                    }
                  }
                })
            }
          )
        }
        .width(this.activeBarWidth())
        .height(this.activeBarHeight())
        .position(this.activeBarPosition())
        .backgroundColor(this.activeColor)
        .zIndex(4)
        .animation(this.activeBarAnimation())
      }
      .width(this.sliderBarWidth())
      .height(this.sliderBarHeight())
      .margin(this.sliderBarMargin())
      .backgroundColor('#ebedf0')
      .opacity(this.opacityValue())
    }
    .width(this.sliderWrapperWidth())
    .height(this.sliderWrapperHeight())
    .onTouch((event: TouchEvent) => {
      if (this.disabled) return

      if (event.type == TouchType.Down) {
        if (this.vertical) {
          this.clickValue = event.touches[0].y
        } else {
          this.clickValue = event.touches[0].x
        }
      }
    })
    .onClick((event: ClickEvent) => {
      if (this.disabled) return

      const currentValue = this.clickValue / this.sliderWidth * this.scoped() + this.min

      if (this.range) {
        const [left, right] = this.rangeValue
        const middle = (left + right) / 2

        if (currentValue <= middle) {
          this.updateValue([currentValue, right])
        } else {
          this.updateValue([left, currentValue])
        }
        if (typeof this.change ==='function') {
          this.change(this.rangeValue)
        }
      } else {
        this.updateValue(currentValue)
        if (typeof this.change === 'function'){
          this.change(this.value)
        }
      }
    })
  }
}
