import { LineProgress } from './progress.ets'

export function initLinePath() {
  const { trackThickness } = this.curIns as LineProgress
  const width = vp2px(this.layoutWidth as number)
  const height = vp2px(this.layoutHeight as number)

  this.path =  `M0 ${height/2} L${width} ${height/2}`
  this.arcLength = this.layoutWidth
}

export function initLineStroke() {
  if(!this.indeterminate) {
    this.strokeArray = [this.arcLength]
    this.strokeOffset = this.arcLength - this.value * this.arcLength / 100
  } else {
    const animate = this.arcLength * 0.6
    this.strokeArray = [animate, this.arcLength]
    this.strokeOffset = animate
  }
}

export function setLineActionTrigger() {
  if(this.indeterminate) {
    this.strokeOffset = this.indicatorDirection ? -this.arcLength : this.arcLength + this.arcLength * 0.6
  }
}

export function resetLineActionTrigger() {
  if(this.indeterminate && this.strokeArray.length === 2) {
    this.strokeOffset = this.arcLength * 0.6
  }
}

export function switchLineMode() {
  if(!this.indeterminate && this.strokeArray.length === 2) {
    this.strokeArray = [this.arcLength]
    const value = this.value < 0 ? 0 : this.value > 100 ? 100 : this.value
    this.strokeOffset = this.arcLength - value * this.arcLength / 100
  } else {
    const animate = this.arcLength * 0.6
    this.strokeArray = [animate, this.arcLength]
    this.strokeOffset = animate
  }
}