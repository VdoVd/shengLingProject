@Component
export default struct searchView{

  @Prop placeHolder:string=''

  build() {
    Column(){

      TextInput({placeholder:this.placeHolder})
        .width('90%')

    }
  }
}