import ListView from '../List'

@Component
export default struct RunningView{

  build() {
    Column(){
      ListView()
    }.width('100%').height('100%')
  }

}