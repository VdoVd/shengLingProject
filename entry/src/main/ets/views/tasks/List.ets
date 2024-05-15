import { TaskItem } from '../../common/http/task'
import ListItemView from './ListItem'

@Component
export default struct ListView{

  @Consume list:TaskItem[]
  @Consume loadingFlag:boolean
  @Consume refreshingFlag:boolean
  build() {
    if(!this.loadingFlag)
    Refresh({refreshing:$$this.refreshingFlag}){


      List(){
        ForEach(this.list,(item:TaskItem,index:number)=>{
          ListItem(){
            ListItemView({item:item})
          }
        })
      }.height('100%').width('100%')


    }.height('100%').width('100%')

  }

}