import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:s3_storage/s3_storage.dart';
import 'pdf_copresser.dart';

class AwsUploadHelper {
  static String claim = "";

  static Future<String?> uploadProfile(File file) async {
    print("file>> ${file.path}");
    print("fileName ${file.path.split('/').last}");
    print("fileName ${file.path.split('/').last}");

    File? compressedFile = await compressFile(file: file);
    String? respone;
    try {
      final s3_storage = S3Storage(
        endPoint: 'amable.s3.ap-south-1.amazonaws.com',
        accessKey: Credentials.AWS_ACCESS_KEY,
        region: 'ap-south-1',
        signingType: SigningType.V4,
        enableTrace: true,
        secretKey: Credentials.AWS_SECRET_ACCESS_KEY,
      );

      var bytes = await compressedFile!.readAsBytes();
      String r = await s3_storage.putObject(
        Credentials.s3_bucketName,
        Credentials.s3FolderProfilePath + compressedFile.path.split('/').last,
        Stream.value(bytes),
        onProgress: (bytes) {
          respone = compressedFile.path.split('/').last;
        },
      );
      // String r = await s3_storage.fPutObject(Credentials.s3_bucketName,
      //     Credentials.s3FolderPath + file.path.split('/').last, file.path);
    } on Exception catch (e) {
      print(" S3 Upload Error------------------> $e");
    }
    //f45c68acf8ccde4d6c041dfa0b365d4d
    print("respone>uploadFile $respone");
    return respone;
  }

  static Future<String?> uploadExpences(File file) async {
    print("file>> ${file.path}");
    print("fileName ${file.path.split('/').last}");
    print("fileName ${file.path.split('/').last}");

    File? compressedFile = await compressFile(file: file);
    String? respone;
    try {
      final s3_storage = S3Storage(
        endPoint: 'amable.s3.ap-south-1.amazonaws.com',
        accessKey: Credentials.AWS_ACCESS_KEY,
        region: 'ap-south-1',
        signingType: SigningType.V4,
        enableTrace: true,
        secretKey: Credentials.AWS_SECRET_ACCESS_KEY,
      );

      var bytes = await compressedFile!.readAsBytes();
      String r = await s3_storage.putObject(
        Credentials.s3_bucketName,
        Credentials.s3FolderExpensesPath + compressedFile.path.split('/').last,
        Stream.value(bytes),
        onProgress: (bytes) {
          respone = compressedFile.path.split('/').last;
        },
      );
    } on Exception catch (e) {
      print(" S3 Upload Error------------------> $e");
    }
    //f45c68acf8ccde4d6c041dfa0b365d4d
    print("respone>uploadFile $respone");
    return respone;
  }

  static Future<String?> uploadFile(File file) async {
    print("file>> ${file.path}");

    print("fileName ${file.path.split('/').last}");

    File? compressedFile = await compressFile(file: file);
    String? respone;
    try {
      final s3_storage = S3Storage(
        endPoint: 'amable.s3.ap-south-1.amazonaws.com',
        accessKey: Credentials.AWS_ACCESS_KEY,
        region: 'ap-south-1',
        signingType: SigningType.V4,
        enableTrace: true,
        secretKey: Credentials.AWS_SECRET_ACCESS_KEY,
      );
      var bytes = await compressedFile!.readAsBytes();
      String r = await s3_storage.putObject(
        Credentials.s3_bucketName,
        Credentials.s3FolderPath + compressedFile.path.split('/').last,
        Stream.value(bytes),
        onProgress: (bytes) {
          respone = compressedFile.path.split('/').last;
        },
      );
    } on Exception catch (e) {
      print(" S3 Upload Error------------------> $e");
    }
    //f45c68acf8ccde4d6c041dfa0b365d4d
    print("respone>uploadFile $respone");
    return respone;
  }

  static Future<String?> uploadFileEvidences(File file, String claimNum) async {
    claim = claimNum.toString();
    File? compressedFile = await compressFile(file: file);
    String? respone;
    try {
      final s3_storage = S3Storage(
        endPoint: 'amable.s3.ap-south-1.amazonaws.com',
        accessKey: Credentials.AWS_ACCESS_KEY,
        region: 'ap-south-1',
        signingType: SigningType.V4,
        enableTrace: true,
        secretKey: Credentials.AWS_SECRET_ACCESS_KEY,
      );
      var bytes = await compressedFile!.readAsBytes();
      String r = await s3_storage.putObject(
        Credentials.s3_bucketName,
        Credentials.s3FolderEvidencesPath +
            "$claim/Evidences/" +
            compressedFile.path
                .split('/')
                .last
                .toLowerCase()
                .replaceAll(" ", ""),
        Stream.value(bytes),
        onProgress: (bytes) {
          respone = compressedFile.path.split('/').last;
        },
      );
    } on Exception catch (e) {
      print(" S3 Upload Error------------------> $e");
    }
    //f45c68acf8ccde4d6c041dfa0b365d4d
    print("respone>uploadFile $respone");
    return respone;
  }

  static Future<File?> compressFile({required File file}) async {
    if (file.path.split('/').last.contains('pdf')) {
      String outputPath = await getTempPath();

      try {
        String size3 = await getFileSize(file);
        print("Size>>> croppedFile $size3  ");

        try {
          if (size3 != "") {
            await PdfCompressor.compressPdfFile(
              file.path,
              outputPath,
              CompressQuality.MEDIUM,
            ).catchError((onError) {
              return file;
            });
          } else {
            return file;
          }
        } on Exception catch (e) {
          return file;
        }
        // file = ;

        return File(outputPath);
      } catch (e) {
        print("Exception<>> $e");
      }
    }
    /*else if (file.path.split('/').last.contains('mov') ||
        file.path.split('/').last.contains('mp4')) {
      return _compressVideo(file);
    }*/
    else {
      return file;
    }
  }

/*  static Future<File?> _compressVideo(File file) async {
    await VideoCompress.setLogLevel(0);
    try {
      final info = await VideoCompress.compressVideo(
        file.path,
        quality: VideoQuality.LowQuality,
        deleteOrigin: true,
        includeAudio: true,
      );
      return File(info!.path!);
    } on Exception catch (e) {
      VideoCompress.cancelCompression();
    }
    //  print(info!.path);
  }*/
}

class Credentials {
  static const String s3_poolD =
      "ap-south-1:6c7a831c-07a4-4237-a022-1e9bdc583436";
  static const String s3_bucketName = "uploads";
  static const String AWS_ACCESS_KEY = "AKIAZOI2FQNEUSW3RFUE";
  static const String AWS_SECRET_ACCESS_KEY =
      "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";
  static const String s3FolderProfilePath = "user/";
  static const String s3FolderEvidencesPath = "case/";
  static const String s3FolderPath = "investigator/";
  static const String s3FolderExpensesPath = "expenses/";
}

String _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

Future<String> getTempPath() async {
  var dir = await getExternalStorageDirectory();
  await new Directory('${dir!.path}/CompressPdfs').create(recursive: true);

  String randomString = getRandomString(10);
  String pdfFileName = '$randomString.pdf';
  return '${dir.path}/CompressPdfs/$pdfFileName';
}

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

getFileSize(File image) async {
  return getFileSizeString(bytes: image.lengthSync());
}


String getFileSizeString({required int bytes, int decimals = 0}) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  var i = (log(bytes) / log(1024)).floor();
  var suffix = suffixes[i];
  if (suffix == "b" || suffix == "kb") {
    return "";
  }
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffix;
}