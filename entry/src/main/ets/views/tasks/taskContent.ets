import finishView from './finishView'

@Component
export default struct taskContent{

  @State
  selectNumber:number = 0

  @Builder
  tarBarBuilder(name:string,index:number){
    Column(){

      Text(name)
        .fontColor(this.selectNumber===index?Color.Red:Color.Black)

    }
  }

  build() {

    Tabs(){

      TabContent(){

      }.tabBar(this.tarBarBuilder('待提货',0))

      TabContent(){

      }.tabBar(this.tarBarBuilder('在途',1))

      TabContent(){
        Scroll(){

          Column(){
            finishView()
          }.height('100%')
          .justifyContent(FlexAlign.Start)

        }.height('100%')
      }.tabBar(this.tarBarBuilder('已完成',2))

    }.onTabBarClick((index)=>{
      this.selectNumber=index
    })

  }

}