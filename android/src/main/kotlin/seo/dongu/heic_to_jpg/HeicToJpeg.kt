package seo.dongu.heic_to_jpg

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.File
import java.io.FileOutputStream
import java.lang.Exception

fun convertHeicToJpeg(heic: String, outputFile: String) : String? {
    try {
        val bitmap = BitmapFactory.decodeFile(heic)
        val file = File(outputFile)
        file.createNewFile()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, FileOutputStream(file));
        return file.path
    }catch (e:Exception){
    }
    return null
}