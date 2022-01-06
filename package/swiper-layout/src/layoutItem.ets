export interface Item {
  body: Render
  floatLayer: Render
  floatWidth?: number
  floatHeight?: number
  floatDirect: PanDirection
}

export class Render {
  builder: any
  constructor(value) {
    this.builder = value
  }
}

@Component
export struct LayoutItem {
  @State body: Render = new Render(null)
  @State floatLayer: Render = new Render(null)
  @State floatWidth: number = 120
  @State floatHeight: number = 50
  @State floatDirect: PanDirection = PanDirection.Left

  @State mainOffsetX: number | string = 0
  @State mainOffsetY: number | string = 0
  @State floatOffsetX: number | string = 0
  @State floatOffsetY: number | string = 0

  private mainDirection: PanDirection

  @Builder builder(dom: Render) {
    dom.builder()
  }

  private aboutToAppear () {
    this.init()
  }

  private getMainDirection(floatDirect: PanDirection) {
    let direct = PanDirection.Horizontal
    switch(floatDirect) {
      case PanDirection.All:
      case PanDirection.Horizontal:
      case PanDirection.Left:
      case PanDirection.Right:
        direct = PanDirection.Horizontal
        break
      case PanDirection.Vertical:
      case PanDirection.Up:
      case PanDirection.Down:
        direct = PanDirection.Vertical
        break
    }
    return direct
  }

  private init() {
    this.mainDirection = this.getMainDirection(this.floatDirect)
    this.setMainTranslate()
    this.setFloatTranslate()
  }

  private setMainTranslate(offsetX: number = 0, offsetY:number = 0) {
    console.log('main offset:   ' + offsetX)
    switch(this.floatDirect) {
      case PanDirection.All:
      case PanDirection.Horizontal:
      case PanDirection.Left:
        this.mainOffsetX = offsetX
        this.mainOffsetY = offsetY
        break
      case PanDirection.Right:
        this.mainOffsetX = offsetX - this.floatWidth
        this.mainOffsetY = offsetY
        break
      case PanDirection.Vertical:
      case PanDirection.Up:
        this.mainOffsetY = 0
        break
      case PanDirection.Down:
        this.mainOffsetY = 0
        break
    }
  }

  private setFloatTranslate(offsetX: number = 0, offsetY:number = 0) {
    switch(this.floatDirect) {
      case PanDirection.All:
      case PanDirection.Horizontal:
      case PanDirection.Left:
        this.floatOffsetX = offsetX
        this.floatOffsetY = offsetY
        break
      case PanDirection.Right:
        this.floatOffsetX = offsetX - this.floatWidth
        this.floatOffsetY = offsetY
        break
      case PanDirection.Vertical:
      case PanDirection.Up:
        this.floatOffsetY = offsetY
        break
      case PanDirection.Down:
        this.floatOffsetY = offsetY - 2 * this.floatHeight
        break
    }
  }

  private setActiveEnd(offsetX: number = 0, offsetY:number = 0) {
    console.info('ActiveEnd offsetX:  ' + offsetX)
    console.info('ActiveEnd offsetY:  ' + offsetY)
    switch(this.floatDirect) {
      case PanDirection.All:
      case PanDirection.Horizontal:
      case PanDirection.Left:
        if(offsetX < 0) {
          this.setMainTranslate(- this.floatWidth, 0)
          this.setFloatTranslate(- this.floatWidth, 0)
        } else {
          this.setMainTranslate()
          this.setFloatTranslate()
        }
        break
      case PanDirection.Right:
        if (offsetX > 0) {
          this.setMainTranslate(this.floatWidth, 0)
          this.setFloatTranslate(this.floatWidth, 0)
        } else {
          this.setMainTranslate()
          this.setFloatTranslate()
        }
        break
      case PanDirection.Vertical:
      case PanDirection.Up:
        if(offsetY < 0) {
          this.setFloatTranslate(0, -this.floatHeight)
        } else {
          this.setFloatTranslate(0, this.floatHeight)
        }
        break
      case PanDirection.Down:
        if(offsetY > 0) {
          this.setFloatTranslate(0, this.floatHeight)
        } else {
          this.setFloatTranslate()
        }
        break
    }
  }

  build() {
    if(this.mainDirection === PanDirection.Horizontal) {
      Row() {
        if (this.floatDirect === PanDirection.Left) {
          Row(){
            this.builder(this.body)
          }.width('100%').height(this.floatHeight)
          .translate({ x: this.mainOffsetX, y: this.mainOffsetY, z: 5 })
        } else if(this.floatDirect === PanDirection.Right) {
          Row(){
            this.builder(this.floatLayer)
          }.height(this.floatHeight)
          .translate({ x: this.floatOffsetX, y: this.floatOffsetY, z: 5 })
        }

        if(this.floatDirect === PanDirection.Left) {
          Row(){
            this.builder(this.floatLayer)
          }.height(this.floatHeight)
          .translate({ x: this.floatOffsetX, y: this.floatOffsetY, z: 5 })
        } else if(this.floatDirect === PanDirection.Right) {
          Row(){
            this.builder(this.body)
          }.width('100%').height(this.floatHeight)
          .translate({ x: this.mainOffsetX, y: this.mainOffsetY, z: 5 })
        }
      }.width('100%').clip(true)
      .gesture(
      PanGesture({direction: PanDirection.Horizontal})
        .onActionStart(() => {
          console.info('Pan start')
        })
        .onActionUpdate((event: GestureEvent) => {
          this.setMainTranslate(event.offsetX, event.offsetY)
          this.setFloatTranslate(event.offsetX, event.offsetY)
        })
        .onActionEnd((event: GestureEvent) => {
          this.setActiveEnd(event.offsetX, event.offsetY)
        })
      )
    } else {
      Column() {
        Row(){
          this.builder(this.body)
        }.height(this.floatHeight).width('100%')
        .translate({ y: this.mainOffsetY, z: 5 })




        Row(){
          this.builder(this.floatLayer)
        }.height(this.floatHeight).width('100%')
        .translate({ y: this.floatOffsetY, z: 5 })
      }.width('100%').height(this.floatHeight).clip(true)
      .gesture(
      PanGesture({direction: PanDirection.Vertical})
        .onActionStart(() => {
          console.info('Pan start')
        })
        .onActionUpdate((event: GestureEvent) => {
          this.setMainTranslate(event.offsetX, event.offsetY)
          this.setFloatTranslate(event.offsetX, event.offsetY)
        })
        .onActionEnd((event: GestureEvent) => {
          this.setActiveEnd(event.offsetX, event.offsetY)
        })
      )
    }
  }
}