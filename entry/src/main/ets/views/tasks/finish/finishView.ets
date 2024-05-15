import { HmDateTimePicker } from '../../../common/components/index'
import ListView from '../List'
import searchView from '../searchView'

@Component
export default struct finishView{

  build() {
    Column({space:15}){

      searchView({placeHolder:'请输入任务编号'})

      Row({space:10}){
        TextInput({placeholder:'开始时间'}).layoutWeight(1)
        Text('至')
        TextInput({placeholder:'结束时间'}).layoutWeight(1)
        Button('筛选')
          .backgroundColor(Color.Red)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }.padding({left:10,right:10})
      ListView().layoutWeight(1)

    }.height('100%')
  }

}