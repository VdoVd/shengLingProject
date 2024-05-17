import { TaskItem } from '../../common/http/task'
import { router } from '@kit.ArkUI'
import { taskId } from '../../pages/detailPage'

@Component
export default struct ListItemView
{

  item:TaskItem={} as TaskItem

  @State buttonText:string=''
  @State isLoadingButton:boolean=true
  aboutToAppear(): void {
    this.getButtonText()
    console.log(`button:${this.buttonText}`)
  }
  getButtonText(){
    this.isLoadingButton=true
    const value = parseInt(this.item.status)
    console.log('value:'+value)
    if(value===1){
      this.buttonText='提货'
    }else if(value===2){
      this.buttonText='交付'
    }else {
      this.buttonText='回车登录'
    }
    this.isLoadingButton=false
  }

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

        Row(){
          Column(){
            Text('提货时间').width('100%').fontSize(12).fontColor(Color.Gray)
            Text(`${this.item.enablePickUp?this.item.planArrivalTime:this.item.planArrivalTime}`).width('100%').fontSize(18).fontColor(Color.Black)
          }.layoutWeight(1)
          if(this.isLoadingButton===false)
          Button(`${this.buttonText}`).backgroundColor(Color.Red).fontColor(Color.White).enabled(this.item.enablePickUp).onClick(()=>{
            let obj:taskId={tid:parseInt(this.item.id)}
            router.pushUrl({
              url:'pages/detailPage',
              params:this.item
            })
          })
        }.width('100%')

      }.padding(15)
    .onClick(()=>{

    })
  }
}