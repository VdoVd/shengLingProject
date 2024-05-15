import { TaskItem } from '../../common/http/task'

@Component
export default struct ListItemView
{
  @Prop
  item:TaskItem
  build() {
      Column({space:20}){

        Row(){
          Text(`任务编号:${this.item.transportTaskId}`).layoutWeight(1)

        }.width('100%')

        Row({space:15}){

          Text('起').backgroundColor(Color.Black).fontColor(Color.White)
            .padding(5)
            .borderRadius(20)
            .fontSize(15)

          Text(`${this.item.startAddress}`).fontSize(12).fontColor(Color.Gray)

        }.justifyContent(FlexAlign.Start).width('100%')

        Row({space:15}){

          Text('止').backgroundColor(Color.Red).fontColor(Color.White)
            .padding(5)
            .borderRadius(20)
            .fontSize(15)

          Text(`${this.item.endAddress}`).fontSize(12).fontColor(Color.Gray)

        }.justifyContent(FlexAlign.Start).width('100%')
      }.padding(15)
  }
}