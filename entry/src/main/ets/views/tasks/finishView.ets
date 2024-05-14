import searchView from './searchView'

@Component
export default struct finishView{

  build() {
    Column(){

      searchView({placeHolder:'请输入任务编号'})


    }
  }

}