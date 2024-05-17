import { getUnFinishTaskData, TaskItem } from '../../common/http/task'
import { TaskListItem, TaskListItemModel } from '../../common/models'
import finishView from './finish/finishView'
import RunningView from './running/RunningView'
import unFinishContent from './unfinish/unfinishContent'
import { promptAction } from '@kit.ArkUI'

@Component
export default struct taskContent{

  @State @Watch("flash") selectNumber:number = 0

  @State
  page:number=1
  @State
  pageSize:number=5
  @State
  status:number=1

  @Provide
  list:TaskItem[]=[]

  @Provide
  loadingFlag:boolean=true

  @Provide
  @Watch("refreshFunc") refreshingFlag:boolean=false

  @State url:string=`/tasks/list?page=${this.page}&pageSize=${this.pageSize}&status=${this.status}`


  @Builder
  tarBarBuilder(name:string,index:number){
    Column(){

      Text(name)
        .fontColor(this.selectNumber===index?Color.Red:Color.Black)

    }
  }

  async aboutToAppear(): Promise<void> {

    await this.getData()
  }

  private async getData() {
    this.loadingFlag = true

    await this.getList()

    this.loadingFlag = false
  }

  private async getList() {
    this.url=`/tasks/list?page=${this.page}&pageSize=${this.pageSize}&status=${this.status}`
    this.list = [...(await getUnFinishTaskData(this.url)).items]
  }

  async flash(){

    this.page=1

    if(this.selectNumber===0){

      this.status=1

    }else if(this.selectNumber===1){

      this.status=2

    }else{

      this.status=6

    }

    await this.getData()

  }
  @State refreshTime:number=2000
  async refreshFunc(){
    if(this.refreshingFlag===true){

      let timeId=setInterval(()=>{
        if(this.refreshTime===0){
          clearInterval(timeId)
          this.refreshTime=2000
        }else {
          this.refreshTime-=100
        }
        if(this.refreshTime<300){
          promptAction.showToast({message:'已经到底了'})
          this.refreshingFlag=false
        }
      },100)
      await this.getRefreshData()

    }
  }

  private async getRefreshData() {
    this.page++
    this.url = `/tasks/list?page=${this.page}&pageSize=${this.pageSize}&status=${this.status}`
    this.list.unshift(...[...(await getUnFinishTaskData(this.url)).items])
    this.list = [...this.list]
    this.refreshTime=0
    this.refreshingFlag = false
  }

  build() {

    Tabs({index:this.selectNumber}){

      TabContent(){
        unFinishContent().width('100%').height('100%')
      }.tabBar(this.tarBarBuilder('待提货',0))
      .height('100%')
      TabContent(){
        RunningView().width('100%').height('100%')
      }.tabBar(this.tarBarBuilder('在途',1))
      .height('100%')
      TabContent(){

        finishView().height('100%').width('100%')

      }.tabBar(this.tarBarBuilder('已完成',2))
      .height('100%')
    }.onTabBarClick((index)=>{
      this.selectNumber=index
    })
    .height('100%')

  }

}