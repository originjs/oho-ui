import { LayoutItem,Item, Render } from './layoutItem.ets'
export { Item, Render } from './layoutItem.ets'

@Component
export struct OhSwiperLayout {
  @State layoutItems: Item[] = []


  build() {
    List() {
      ForEach(this.layoutItems, (item) => {
        ListItem() {
          Column() {
            LayoutItem({
              body: item.body,
              floatLayer: item.floatLayer,
              floatDirect: item.floatDirect,
              floatWidth: item.floatWidth,
              floatHeight: item.floatHeight
            })
          }
        }
      });
    }
  }
}
