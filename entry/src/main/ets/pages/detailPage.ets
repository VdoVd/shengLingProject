import { router } from '@kit.ArkUI'
import { getDetailTaskData, taskDetailData } from '../common/http/task'

export interface taskId{
  tid:number
}

@Entry
@Component
struct DetailPage {


  data:taskDetailData=router.getParams() as taskDetailData
  @State loadingData:boolean=true
  async onPageShow(): Promise<void> {
    await this.getData()
  }



  private async getData() {

    this.loadingData = true

    this.data = await getDetailTaskData(this.data.id.toString())

    console.log(`getData:${JSON.stringify(this.data)}`)

    this.loadingData = false

  }

  build() {

    Stack(){

      Text('取消任务')

      Navigation(){



      }.title('任务详情')

      .titleMode(NavigationTitleMode.Mini)

    }.alignContent(Alignment.TopEnd).padding(15)

  }

}
