@Component
export struct OhStepper {
  @State @Watch("watchValue") value: number = 1;
  @State min: number = -Infinity;
  @State max: number = Infinity;
  @State step: number = 1;
  @State size: number = 30;
  @State bgColor: string = '#f3f3f3';
  @State integer: boolean = false;
  @State minusOpacity: number = 1
  @State minusActivated: boolean = true
  @State plusOpacity: number = 1
  @State plusActivated: boolean = true

  private input

  trimExtraChar(value: string, char: string, regExp: RegExp) {
    const index = value.indexOf(char);

    if (index === -1) {
      return value;
    }

    if (char === '-' && index !== 0) {
      return value.slice(0, index);
    }

    return value.slice(0, index + 1) + value.slice(index).replace(regExp, '');
  }

  formatNumber(value: string, allowDot: boolean) {
    if (allowDot) {
      value = this.trimExtraChar(value, '.', /\./g);
    } else {
      value = value.split('.')[0];
    }

    const regExp = allowDot ? /[^-0-9.]/g : /[^-0-9]/g;

    return value.replace(regExp, '');
  }

  watchValue() {
    this.value = parseFloat(this.formatNumber(this.value.toString(),!this.integer))
    console.info('### value = ' + this.value)
    if (this.value <= this.min) {
      this.value = this.min
      this.minusOpacity = 0.5
      this.minusActivated = false
    } else if (this.value >= this.max) {
      this.value = this.max
      this.plusOpacity = 0.5
      this.plusActivated = false
    } else {
      this.minusOpacity = 1;
      this.minusActivated = true;
      this.plusOpacity = 1;
      this.plusActivated = true;
    }
  }

  build() {
    Row(){
      Button({ type: ButtonType.Normal, stateEffect: this.minusActivated }) {
        Text('-')
          .fontColor(Color.Black)
          .fontSize(16)
      }
      .borderRadius(2)
      .width(this.size)
      .height(this.size)
      .backgroundColor(this.bgColor)
      .opacity(this.minusOpacity)
      .onClick(() => {
        if (this.value > this.min) {
          if (typeof this.input === 'function'){
            this.input()
          }
          if (this.value - this.step > this.min) {
            this.value -= this.step;
          } else {
            this.value = this.min;
            this.minusOpacity = 0.5;
            this.minusActivated = false;
          }
          this.plusOpacity = 1
          this.plusActivated = true
        }
      })

      TextInput({ placeholder: this.value.toString(), text: this.value.toString() })
        .placeholderFont({ size: 32 })
        .width(this.size * 1.5)
        .height(this.size)
        .backgroundColor(this.bgColor)
        .borderRadius(0)
        .margin({ right: 2, left: 2 })
        .type(InputType.Number)
        .onChange(
          (value) => {
            if (value == '') {
              value = '0'
            }
            var parsedValue = parseFloat(this.formatNumber(value, !this.integer))
            if (parsedValue < this.min) {
              this.value = this.min
            } else if (parsedValue > this.max) {
              this.value = this.max
            } else {
              this.value = parsedValue
            }
        )

      Button({ type: ButtonType.Normal, stateEffect: this.plusActivated }) {
        Text('+')
          .fontColor(Color.Black)
          .fontSize(16)
        }
      .borderRadius(2)
      .width(this.size)
      .height(this.size)
      .backgroundColor(this.bgColor)
      .opacity(this.plusOpacity)
      .onClick(() => {
        if (this.value < this.max) {
          if (typeof this.input === 'function'){
            this.input()
          }
          if (this.value + this.step < this.max) {
            this.value += this.step
          } else {
            this.value = this.max;
            this.plusOpacity = 0.5;
            this.plusActivated = false;
          }
          this.minusOpacity = 1
          this.minusActivated = true
        }
      })
    }
  }
}
