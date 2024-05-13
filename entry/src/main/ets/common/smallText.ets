@Component
export default struct smallText{
  @Prop name:string='未定义'
  @Prop color:Color|string=Color.Black
  @Prop textAlign:TextAlign=TextAlign.Start
  @Prop fontSize:number=12
  build() {
    Text(this.name).fontSize(this.fontSize).fontColor(this.color).textAlign(TextAlign.Center)
  }
}