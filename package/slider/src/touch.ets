export class Touch {
  startX: number = 0
  startY: number = 0
  deltaX: number = 0
  deltaY: number = 0

  start(event: TouchEvent) {
    this.reset()
    const touch = event.touches[0]
    this.startX = touch.screenX
    this.startY = touch.screenY
  }

  move(event: TouchEvent) {
    const touch = event.touches[0]
    this.deltaX = touch.screenX - this.startX
    this.deltaY = touch.screenY - this.startY
  }

  reset() {
    this.deltaX = 0
    this.deltaY = 0
  }
}
