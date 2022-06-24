package seo.dongu.heic_to_jpg

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.File
import java.io.FileOutputStream
import java.lang.Exception
import java.util.logging.Logger;

fun convertHeicToJpeg(heic: String, outputFile: String,compressionQuality: Int) : String? {
    try {
        val bitmap = BitmapFactory.decodeFile(heic)
        val file = File(outputFile)
        file.createNewFile()
        bitmap.compress(Bitmap.CompressFormat.JPEG, compressionQuality, FileOutputStream(file));
        return file.path
    }catch (e:Exception){
        var logger = Logger.getLogger("MyLogger");
        logger.info(e.toString());
    }
    return null
}