import { httpClass } from './req'
import { promptAction } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit'
import { image } from '@kit.ImageKit'

export const getCaptcha= async (phone:string)=>{

  let req = http.createHttp()

  const res=await req.request(`http://192.168.110.1:8080/captcha?phone=${phone}`,{
    expectDataType:http.HttpDataType.ARRAY_BUFFER
  })

  let pixelMap =await image.createImageSource(res.result as ArrayBuffer).createPixelMap()

  if(pixelMap!=undefined){

    promptAction.showToast({message:'接收验证码成功'})

  }else {

    promptAction.showToast({message:'接收验证码失败'})

  }

  return pixelMap
}

export interface registerInterface{
  phone:string
  code:string
}
export const register = async (phone:string,code:string)=>{

  const res =await httpClass.post<boolean>('/captcha/register',{
    phone:phone,
    code:code
  } as registerInterface)

  if(res){
    promptAction.showToast({message:'注册成功'})
  }else {
    promptAction.showToast({message:'注册失败'})
  }
  return res
}