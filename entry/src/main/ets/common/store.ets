import { SysUser } from './Model'
import { preferences } from '@kit.ArkData'

PersistentStorage.persistProp<SysUser>('SysUser',{} as SysUser)

export class allStore{

}

export class userStore{

  private static user:SysUser={} as SysUser

  public static setUser(user:SysUser){
    console.log(`setUser:${JSON.stringify(user)}`)
    userStore.user=user
  }

  public static getUser(){
    return userStore.user
  }

}

export class tokenStore{

  private static token:string

  public static setToken(token:string){
    console.log(`token:${token}`)
    tokenStore.token=token
  }

  public static getToken(){
    return tokenStore.token
  }

}
