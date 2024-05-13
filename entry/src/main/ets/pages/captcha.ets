import { getCaptcha, register } from '../common/http/login'
import { image } from '@kit.ImageKit'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct Login {
  @State username:string='admin'
  @State password:string='123456'
  @State code:string=''
  @State phone:string=''
  @State img:image.PixelMap={} as image.PixelMap
  @State getCaptcha:boolean=false
  build() {
    Row() {
      Column({space:15}) {

        Text('物流系统')
          .width('100%')
          .textAlign(TextAlign.Center)

        Row(){
          Text('手机号登录').fontWeight(FontWeight.Bolder).fontSize(25)
          Text('账号登录').fontColor(Color.Red).fontSize(17)
        }.justifyContent(FlexAlign.SpaceBetween).width('100%')

        TextInput({placeholder:'请输入手机号',text:$$this.phone}).width('100%')
        Row({space:15}){
          TextInput({placeholder:'请输入验证码',text:$$this.code}).layoutWeight(1)
          if(this.getCaptcha===false)
          Button('获取验证码').onClick(async ()=>{
            if(this.phone===''){

              promptAction.showToast({message:'验证码为空'})

            }else{

                this.img=await getCaptcha(this.phone)
                if(this.img!=undefined){
                  this.getCaptcha=true
                }else {
                  this.getCaptcha=false
                }


            }

          })
          else
            Image(this.img).width(60)
              .margin({right:15})
              .onClick(async ()=>{
                this.img=await getCaptcha(this.phone)
              })
        }.width('100%')

        Button('注册')
          .onClick(async ()=>{
            const res=await register(this.phone,this.code)
            if(res)
            router.pushUrl({
              url:'pages/Login',
            })
          })


      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)
      .padding(20)
    }
    .height('100%')
  }
}