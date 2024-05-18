import { Data, getCarData, PictureList } from '../common/http/mine'

@Entry
@Component
struct Car {

  data:Data= {} as Data
  vals:string[]=[]
  @State isLoading:boolean=true
  async onPageShow(): Promise<void> {
    this.isLoading=true
    this.data=await getCarData()
    this.vals=Object.values(this.data)
    this.isLoading=false
  }

  keys:string[]=[]

  build() {
    Navigation(){
      if(this.isLoading===false){
        Scroll(){
          Column({space:10}){

            Image($r('app.media.mine')).width('100%')

            this.RowItem('车辆信息',this.data.id)
            this.RowItem('车辆号牌',this.data.licensePlate)
            this.RowItem('车型',this.data.truckType)
            this.RowItem('所属机构',this.data.currentOrganName)
            this.RowItem('载重',this.data.allowableLoad+'吨')

          }

        }.height('100%')

      }


    }.title('车辆信息')
    .titleMode(NavigationTitleMode.Mini)
    .height('100%')
  }

  @Builder
  RowItem(key:string,val:string) {
    Row() {
      Text(key).fontColor(Color.Gray)
      Text(val)
    }.width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(20)
  }
}