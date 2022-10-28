
import '../../../utils/imports/imports.dart';

Widget BoldText(String text){
  return Text(text, style: TextStyle(
    fontFamily: 'Brandon Grotesque Bold',
    fontSize: 20.sp,
  ),);
}

Widget SimpleText(String text){
  return Text(text, style: TextStyle(
      fontFamily: 'Brandon Grotesque',
      fontSize: 16.sp
  ),);
}

Widget ButtonContainer (String text){
  return Center(
    child: Container(
      height: 56.h,
      width: 327.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BackgroundColor,
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Brandon Grotesque',
                fontSize: 20.sp,
            fontWeight: FontWeight.w600
            )
        ),
      ),
    ),
  );
}

InputDecoration customInputDecoration ( String labelText){

  return InputDecoration(
    filled: true,
    fillColor: TextfieldColor,
    labelText: labelText,
    contentPadding: EdgeInsets.all(15),
    labelStyle: TextStyle(color: Colors.black45),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent)
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent)
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent)
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent)
    ),);
}

Widget searchRow(TextEditingController searchController, String text){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 288.sp,
        child: TextField(
          cursorColor: Colors.black,
          controller: searchController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              filled: true,
              fillColor: TextfieldColor,
              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search, color: Colors.black,),),
              hintText: text,
              hintStyle: TextStyle(fontFamily: 'Brandon Grotesque',
                  fontSize: 15.sp),
              focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 2
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 2
                  )
              )
          ),
        ),
      ),
      Image(image: AssetImage("assets/images/filterIcon.png")),
    ],
  );
}


