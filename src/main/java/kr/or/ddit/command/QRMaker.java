package kr.or.ddit.command;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class QRMaker {
	public static void make(String filePath, String data) throws WriterException, IOException{



		// QrCode 인스턴스 생성
		QRCodeWriter qrCodeWriter = new QRCodeWriter(); // QR 코드

		// 생성될 큐알 코드 경로 및 파일명..
		OutputStream out = new FileOutputStream(filePath);

		// 한글 데이터가 있을 경우 캐릭터셋 설정을 한다
		data = new String(data.getBytes("UTF-8"), "ISO-8859-1");

		BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, 400, 400);

		// zxing에서 스트림에 파일을 뿌릴수있도록 메소드를 지원함.rw
		MatrixToImageWriter.writeToStream(bitMatrix, "png", out);
	}
}
