import { http } from '@kit.NetworkKit';
import { httpClass } from './req';

export interface PictureList {
  url: string;
}

export interface Data {
  allowableLoad: string;
  id: string;
  licensePlate: string;
  pictureList: PictureList[];
  truckType: string;
  currentOrganName: string;
}
export const getCarData= async ()=>{

  const res = await httpClass.get<Data>('/users/truck')

  console.log(`res:${JSON.stringify(res)}`)

  return res

}