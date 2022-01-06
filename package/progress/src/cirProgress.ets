import { CirProgress } from './progress.ets'

export function initCirPath() {
  const { indicatorSize, indicatorInset, indicatorDirection } = this.curIns as CirProgress
  const pxWidth = vp2px(indicatorSize)
  const pxInset = vp2px(indicatorInset)
  const r = (pxWidth - pxInset) / 2
  const x0 = pxWidth / 2
  const y0 = pxInset / 2
  const y1 = pxWidth - pxInset / 2
  this.path = `M ${x0} ${y0} A ${r} ${r} 0 0 ${indicatorDirection} ${x0} ${y1} A ${r} ${r} 0 0 ${indicatorDirection} ${x0} ${y0}`

  this.arcLength = px2vp(2 * Math.PI * r)
}

export function initCirStroke() {
  if(!this.indeterminate) {
    this.strokeArray = [this.arcLength]
    this.strokeOffset = this.arcLength - this.value * this.arcLength / 100
  } else {
    const animate = this.arcLength * 0.75
    this.strokeArray = [animate, this.arcLength]
    this.strokeOffset = animate
    this.angle = 0
  }
}

export function setCirActionTrigger() {
  if(this.indeterminate) {
    this.strokeOffset = - this.arcLength
    this.angle = this.indicatorDirection === 1 ? 360 : - 360
  }
}

export function resetCirActionTrigger() {
  if(this.indeterminate && this.strokeArray.length === 2) {
    this.strokeOffset = this.arcLength * 0.75
    this.angle = 0
  }
}

export function switchCirMode() {
  if(!this.indeterminate && this.strokeArray.length === 2) {
    this.strokeArray = [this.arcLength]
    const value = this.value < 0 ? 0 : this.value > 100 ? 100 : this.value
    this.strokeOffset = this.arcLength - value * this.arcLength / 100
  } else {
    const animate = this.arcLength * 0.75
    this.strokeArray = [animate, this.arcLength]
    this.strokeOffset = animate
  }
  this.angle = 0
}