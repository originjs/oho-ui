import router from '@system.router';
import { OhSwiperLayout, Item, Render } from 'oho-ui'

@Entry
@Component
export struct SwiperLayoutDem{
  @State layoutItems: Item [] = [
    {
      body: new Render(this.body),
      floatLayer: new Render(this.floatLayer),
      floatWidth: 120,
      floatHeight: 50,
      floatDirect: PanDirection.Left
    },
    {
      body: new Render(this.body),
      floatLayer: new Render(this.floatLayer),
      floatWidth: 120,
      floatHeight: 50,
      floatDirect: PanDirection.Right
    },
    {
      body: new Render(this.body),
      floatLayer: new Render(this.floatLayerV),
      floatWidth: 120,
      floatHeight: 50,
      floatDirect: PanDirection.Up
    },
    {
      body: new Render(this.body),
      floatLayer: new Render(this.floatLayerV),
      floatWidth: 120,
      floatHeight: 50,
      floatDirect: PanDirection.Down
    }
  ]
  @Builder body () {
    Row() {
      Text('这是主视窗').fontSize(30)
    }.width('100%').height('100%').backgroundColor('#ff5722')
  }

  @Builder floatLayer () {
    Row() {
      Text('滑动视窗').fontSize(30)
    }.width(120).backgroundColor('#00bcd4')
  }

  @Builder floatLayerV () {
    Row() {
      Text('滑动视窗').fontSize(30)
    }.width('100%').backgroundColor('#00bcd4')
  }

  build() {
    Column() {
      Button('back home').onClick(() => {
        router.push({
          uri: 'pages/index'
        })
      })
      Row() {
        Row() {}.width('15%')
        Row() {
          OhSwiperLayout({
            layoutItems: this.layoutItems
          })
        }.width('70%')
        Row() {}.width('15%')
      }
      .zIndex(10)
    }
  }
}