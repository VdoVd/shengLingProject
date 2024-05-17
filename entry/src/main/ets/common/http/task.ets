import { httpClass } from './req'

export interface AllReturn<T>{
  code:number
  data:T
  msg:string
}

export interface TaskList {
  counts: number;
  items: TaskItem[];
  page: number;
  pageSize: number;
  pages: number;
}

export interface TaskItem {
  actualArrivalTime: string;
  actualDepartureTime: string;
  created: string;
  driverId: string;
  enablePickUp: boolean;
  endAddress: string;
  endAgencyId: number;
  finishHandover: string;
  id: string;
  planArrivalTime: string;
  planDepartureTime: string;
  startAddress: string;
  startAgencyId: number;
  startHandover: string;
  status: string;
  transportTaskId: string;
}

export interface CargoPickUpPictureList {
  url: string;
}

export interface CargoPictureList {
  url: string;
}

export interface TransportCertificateList {
  url: string;
}

export interface DeliverPictureList {
  url: string;
}

export interface taskDetailData {
  id: string;
  startAgencyId: string;
  startProvince: string;
  startCity: string;
  startAddress: string;
  endAgencyId: string;
  endProvince: string;
  endAddress: string;
  endCity: string;
  status: number;
  driverId: string;
  transportTaskId: string;
  startHandover: string;
  startHandoverPhone: string;
  finishHandover: string;
  finishHandoverPhone: string;
  planDepartureTime?: string;
  actualDepartureTime: string;
  planArrivalTime?: string;
  actualArrivalTime: string;
  licensePlate: string;
  driverName: string;
  cargoPickUpPictureList: CargoPickUpPictureList[];
  cargoPictureList: CargoPictureList[];
  transportCertificateList: TransportCertificateList[];
  deliverPictureList: DeliverPictureList[];
}


export const getUnFinishTaskData = async (url:string) => {
  console.log(`before:${JSON.stringify(url)}`)
  const res = await httpClass.get<TaskList>(url)
  console.log(`getUnFinish:${JSON.stringify(res)}`)
  return res
}

export const getDetailTaskData = async (id:string) =>{

  const res = await httpClass.get<taskDetailData>(`/tasks/details/${id}`)

  return res

}