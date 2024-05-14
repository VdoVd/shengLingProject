import taskContent from '../views/tasks/taskContent'

@Entry
@Component
struct Index {

  @State num:number=0

  @Builder
  tarBarBuilder(title:string,img:Resource,index:number){
    Column({space:15}){
      Image(img).width(20)
        .fillColor(this.num===index?Color.Red:Color.Black)
      Text(title).width('100%').textAlign(TextAlign.Center)
        .fontColor(this.num===index?Color.Red:Color.Black)
    }
  }

  build() {

    Column(){

      Tabs(){
        TabContent(){
          taskContent()
        }.tabBar(this.tarBarBuilder('任务',$r('app.media.task'),0))
        TabContent(){
          Text('mess')
        }.tabBar(this.tarBarBuilder('消息',$r('app.media.mess3'),1))
        TabContent(){
          Text('mine')
        }.tabBar(this.tarBarBuilder('我的',$r('app.media.mine'),2))
      }.onTabBarClick((index)=>{
        this.num=index
      })
      .barPosition(BarPosition.End)

    }

  }
}