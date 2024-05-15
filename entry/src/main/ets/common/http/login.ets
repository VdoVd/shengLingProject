import { httpClass } from './req'
import { promptAction, router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit'
import { image } from '@kit.ImageKit'
import { tokenStore } from '../store'
import { BASE_URL } from '../constants'

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
  account:string
  password:string
}

export interface loginResponse{
  code:number
  data:string
  msg:string
}

export const loginFunc = async (name:string,pass:string)=>{

  const res =await http.createHttp().request(`${BASE_URL}/login/account`,{
    method:http.RequestMethod.POST,
    header: {
      "Content-Type": "application/json"
    },
    extraData:{
      account:name,
      password:pass
    }
  })
  promptAction.showDialog({message:`${JSON.stringify(JSON.parse(res.result.toString()))}`})
  const result = JSON.parse(res.result.toString()) as loginResponse
  tokenStore.setToken(result.data)
  if(result.code===200){
    promptAction.showToast({message:'登录成功'})
  }else {
    promptAction.showToast({message:'登录失败'})
  }
  return res
}