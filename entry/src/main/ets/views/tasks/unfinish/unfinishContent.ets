import ListView from '../List'

@Component
export default struct unFinishContent{

  build() {
    Column(){
      ListView()
    }.width('100%').height('100%')
  }

}