@Component
export struct ohSwitch {
  @Link checked: boolean

  @State disabled: boolean = false
  @State loading: boolean = false
  @State size: number = 30
  @State activeColor: string = '#1989fa'
  @State inactiveColor: string = '#fff'

  private switchBgColor() {
    return this.checked ? this.activeColor : this.inactiveColor
  }

  private switchBorderColor() {
    return this.checked ? this.activeColor : '#e5e5e5'
  }

  private switchNodeTranslate() {
    return this.checked ? { x: this.size } : { x: 0 }
  }

  private input

  build() {
    Column() {
      Column() {
        if (this.loading) {
          LoadingProgress()
        }
      }
      .width(this.size)
      .height(this.size)
      .backgroundColor(Color.White)
      .border({width: 1, color: this.switchBorderColor(), radius: this.size})
      .position({x: -1, y: -1})
      .translate(this.switchNodeTranslate())
      .animation({
        duration: 300,
        curve: Curve.Smooth
      })
    }
    .width(this.size * 2)
    .height(this.size)
    .backgroundColor(this.switchBgColor())
    .border({width: 1, color: 'rgba(0, 0, 0, 0.1)', radius: this.size})
    .animation({
      duration: 300,
      curve: Curve.Smooth
    })
    .opacity(this.disabled ? 0.5 : 1)
    .onClick((event: ClickEvent) => {
      if (this.disabled || this.loading) return
      if (typeof this.input === 'function') {
        this.input()
      } else {
        this.checked = !this.checked
      }
    })
  }
}
