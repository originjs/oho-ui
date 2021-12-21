import { Style, CirProgress, LineProgress } from './progress.ets'
import {
  initCirPath,
  initCirStroke,
  setCirActionTrigger,
  resetCirActionTrigger,
  switchCirMode
} from './cirProgress.ets'
import {
  initLinePath,
  initLineStroke,
  setLineActionTrigger,
  resetLineActionTrigger,
  switchLineMode
} from './lineProgess.ets'

@Component
export struct OhProgress {
  @Prop layoutWidth: number
  @Prop layoutHeight: number
  @State style: number = Style.Line
  @State delay: number = 0
  @State curve: Curve | string = Curve.Linear
  @State trackColor: string = '#d7b6fd'
  @State trackThickness: number = 4
  @State @Watch('switchMode') indeterminate: boolean = false
  @State @Watch('resize') indicatorSize: number = 48
  @State indicatorColor: string = '#6100ee'
  @State showDelay: number = 0
  @State @Watch('resize') indicatorInset: number = 4
  @State @Watch('resize') indicatorDirection: number = 1
  @State @Watch('setValue') value: number = 0
  @State strokeOffset: number = 0
  @State angle: number = 0
  private curIns: CirProgress | LineProgress
  private path: string
  private strokeArray: number[]
  private arcLength: number

  private aboutToAppear(): void {
    this.resize()
  }

  private resize(): void {
    this.curIns = this.getInstance(this.style)
    this.curIns.initPath()
    this.curIns.initStroke()
  }

  private setValue() {
    if(this.indeterminate) return
    const value = this.value < 0 ? 0 : this.value > 100 ? 100 : this.value
    this.strokeOffset = this.arcLength - value * this.arcLength / 100
  }

  private switchMode() {
    this.curIns.switchMode()
  }

  private getInstance (style: number): CirProgress | LineProgress {
    let intance: CirProgress | LineProgress
    const base = {
      trackThickness: this.trackThickness,
      trackColor: this.trackColor,
      indicatorColor: this.indicatorColor,
      indicatorDirection: this.indicatorDirection
    }
    if(style === Style.Line) {
      intance = {
        ...base,
        indeterminateAnimationType: 1,
        initPath: initLinePath.bind(this),
        initStroke: initLineStroke.bind(this),
        setActionTrigger: setLineActionTrigger.bind(this),
        resetActionTrigger: resetLineActionTrigger.bind(this),
        switchMode: switchLineMode.bind(this)
      }
    } else {
      intance = {
        ...base,
        indicatorSize: this.indicatorSize,
        indicatorInset: this.indicatorInset,
        initPath: initCirPath.bind(this),
        initStroke: initCirStroke.bind(this),
        setActionTrigger: setCirActionTrigger.bind(this),
        resetActionTrigger: resetCirActionTrigger.bind(this),
        switchMode: switchCirMode.bind(this)
      }
    }
    return intance
  }

  private enableAnima(): boolean {
    setTimeout(() => {
      animateTo({
        duration: !this.indeterminate ? 500 : 3000,
        curve: this.curve,
        delay: this.delay,
        iterations: this.getIterations(this.indeterminate),
        onFinish: () => {
          this.curIns.resetActionTrigger()
        }
      }, () => {
        this.curIns.setActionTrigger()
      })
    }, 300)
    return false
  }

  private getIterations(value: boolean) {
    return value ? -1 : 0
  }

  build() {
    Shape () {
      Path()
        .commands(this.path)
        .fill('none')
        .stroke(this.trackColor)
        .strokeWidth(this.trackThickness)
        .strokeLineCap(LineCapStyle.Round)
      Path()
        .commands(this.path)
        .fill('none')
        .stroke(this.indicatorColor)
        .strokeWidth(this.indicatorInset)
        .strokeDashArray(this.strokeArray)
        .strokeDashOffset(this.strokeOffset)
        .strokeLineCap(LineCapStyle.Round)
        .rotate({
          x: 0,
          y: 0,
          z: 1,
          centerX: this.indicatorSize / 2,
          centerY: this.indicatorSize / 2,
          angle: this.angle
        })
      if(this.enableAnima()){}
    }.viewPort({
      x: 0,
      y: 0,
      width: this.layoutWidth,
      height: this.layoutHeight
    })
  }
}

export { Style }
