import { http } from '@kit.NetworkKit'
import { ExpectExtend } from '@ohos/hypium'
import { BASE_URL } from '../constants'
import { allResponse, SysUser, SysUserWithToken } from '../Model'
import { tokenStore, userStore } from '../store'
import { AllReturn } from './task'

const baseUrl=BASE_URL

export const Login= async (username:string,password:string)=>{

  console.log('before req')

  let req=await http.createHttp().request(`${baseUrl}/login`,{
    method:http.RequestMethod.POST,
    header: {
      'Content-Type': 'application/json'
    },
    extraData:{
      username:username,
      password:password
    }
  })

  const result=JSON.parse(req.result.toString()) as allResponse<SysUserWithToken>

  console.log(`login result:${JSON.stringify(result)}`)

  if(result.success===true)
  {

    tokenStore.setToken(result.data.token)

    console.log(`user:${result.data.systemUser}`)

    userStore.setUser(result.data.systemUser)

    return true
  }else {
    return false
  }

}

export const test= async ()=>{

  let req=http.createHttp()

  const res=await req.request(`${baseUrl}/test`,{
    method:http.RequestMethod.GET,
    header:{
      token:tokenStore.getToken()
    }
  })

  console.log(`http test:${JSON.stringify(res.result)}`)

}


export class httpClass {

  private static baseUrl = baseUrl

  public static async get<T>(url: string) {

    let req = http.createHttp()

    let res:http.HttpResponse

      res = await req.request(`${baseUrl}${url}`, {
        method: http.RequestMethod.GET,
        header: {
          Authorization: tokenStore.getToken()
        }
      })

    const result = JSON.parse(res.result.toString()) as AllReturn<T>

    console.log(`get result:${JSON.stringify(res.result)}`)

    return result.data
  }

  static async post<T>(url: string, extraData?: Object) {
    try {
      const httpReq = http.createHttp()

      let options: http.HttpRequestOptions = {
        method: http.RequestMethod.POST,
        header: {
          "Content-Type": "application/json"
        },
        expectDataType: http.HttpDataType.OBJECT
      }

      // 1. 判断extraData可选参数如果不为空，则要将其追加到options对象中
      if (extraData) {
        options.extraData = extraData
      }

      // 2. 从AppStorage('user')中获取数据token，如果有值则追加到options.header中的Authorization
      // 使用user?写法，就能规避bug：在undefined上点出token这个属性报错
      if (options.header)
        options.header['token'] = tokenStore.getToken()

      url = baseUrl + url
      // 3. 将动态构建好的options参数和url传给request->发请求获取服务器的响应数据
      let res = await httpReq.request(url, options)

      console.log(`post ${url}:${JSON.stringify(res.result)}`)
      console.log(`result:${(JSON.stringify(res.result))}`)
      const result=res.result as AllReturn<T>
      // let result2:allResponse<T>={} as allResponse<T>
      // result2=JSON.parse(res.result.toString()) as allResponse<T>
      console.log('result.toString():'+result.msg)
      console.log(`data is:${result.data}`)
      //   4. 将服务器的数据返回
      return result.data

    } catch (err) {

      return Promise.reject(err)
    }
  }
}