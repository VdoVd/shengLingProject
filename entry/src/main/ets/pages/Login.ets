import { loginFunc } from '../common/http/login'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct Login {
  @State time:number=5
  @State name:string=''
  @State password:string=''
  onPageShow(): void {
    let timeId=setInterval(()=>{
      this.time--
      if(this.time===0){
        clearInterval(timeId)
      }
    },1000)

  }
  build() {

    Stack(){
      if(this.time>0){
        Image($r('app.media.start'))
          .width('100%')
        Text(`还剩${this.time}秒`).fontColor(Color.Black).fontSize(13)
          .margin({top:15,right:15})
      }


      if(this.time===0)
      Column({space:15}){

        Row({space:15}){
          Text('账号')
          TextInput({placeholder:'请输入账号',text:$$this.name}).layoutWeight(1)
        }

        Row({space:15}){
          Text('密码')
          TextInput({placeholder:'请输入密码',text:$$this.password}).layoutWeight(1)
        }

        Button('登录')
          .onClick(async ()=>{
            const res=await loginFunc(this.name,this.password)
            if(res){
              router.pushUrl({url:'pages/Index'})
            }else {

            }
          }).width('100%')

      }.padding(20)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.TopEnd)

  }

}