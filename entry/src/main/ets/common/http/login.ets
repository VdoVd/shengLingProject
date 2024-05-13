import { httpClass } from './req'
import { promptAction, router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit'
import { image } from '@kit.ImageKit'
import { tokenStore } from '../store'

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

    router.pushUrl({
      url:'pages/Login'
    })
    promptAction.showToast({message:'注册成功'})
  }else {
    promptAction.showToast({message:'注册失败'})
  }
  return res
}

export interface loginInterface{
  name:string
  pass:string
}

export const existRegisterFunc = async (name:string,pass:string)=>{

  const res =await httpClass.post<boolean>('/login',{
    name:name,
    pass:pass
  } as loginInterface)

  if(res){
    promptAction.showToast({message:'注册过'})
  }
  return res
}


export const loginFunc = async (name:string,pass:string)=>{

  const res =await httpClass.post<string>('/login',{
    name:name,
    pass:pass
  } as loginInterface)
  tokenStore.setToken(res.toString())
  if(res!=""){
    promptAction.showToast({message:'登录成功'})
  }else {
    promptAction.showToast({message:'登录失败'})
  }
  return res
}