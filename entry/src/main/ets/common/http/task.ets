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

export const getUnFinishTaskData = async (url:string) => {
  console.log(`before:${JSON.stringify(url)}`)
  const res = await httpClass.get<TaskList>(url)
  console.log(`getUnFinish:${JSON.stringify(res)}`)
  return res
}