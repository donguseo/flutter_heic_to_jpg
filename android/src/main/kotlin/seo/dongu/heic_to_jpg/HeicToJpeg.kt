package seo.dongu.heic_to_jpg

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.File
import java.io.FileOutputStream
import java.lang.Exception

fun convertHeicToJpeg(heic: String, cacheDir: File?) : String? {
    if(cacheDir == null){
        return null
    }
    try {
        //val fullPath = heic
	    //val directory = fullPath.substringBeforeLast("/")
	    val fullName = heic.substringAfterLast("/")
	    val fileName = fullName.substringBeforeLast(".")
	    //val extension = fullName.substringAfterLast(".")
        
        val bitmap = BitmapFactory.decodeFile(heic)
        val file = File(cacheDir.path + "/${fileName}.jpg")
        file.createNewFile()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, FileOutputStream(file));
        return file.path
    }catch (e:Exception){
    }
    return null
}
