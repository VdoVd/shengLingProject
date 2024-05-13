import { http } from '@kit.NetworkKit'
import { deleteByNameInterface, SysUser } from '../Model'
import { httpClass } from './req'

export interface  updateUserInterface{
  nickname:string,
  username:string
  status:string,
  phonenumber:string
}

export const deleteByName = async (name:string) =>{

  const res = await httpClass.post<boolean>(`/user/delete`,{

    username:name

  } as deleteByNameInterface)

  console.log(`res:${res}`)

  return res
}

export const updateUser= async (theObj:updateUserInterface)=>{
  const res = await httpClass.post<boolean>('/user/update',theObj)
  console.log(`update res:${JSON.stringify(res)}`)
  return res
}