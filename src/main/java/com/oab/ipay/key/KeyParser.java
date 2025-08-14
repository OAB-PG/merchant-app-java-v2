package com.oab.ipay.key;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.ShortBufferException;

public class KeyParser {

	private String id;
	private String password;
	private String key;
	private String webAddress;
	
	public String getId() {
		return id;
	}

	public String getPassword() {
		return password;
	}

	public String getKey() {
		return key;
	}

	public String getWebAddress() {
		return webAddress;
	}

	public KeyParser(String keyPath, String alias) throws Exception {
		getSecretDetails(keyPath, alias);
	}

	private void getSecretDetails(String keyPath, String alias) throws Exception {
		Key key = loadKeys(keyPath + File.separator + "keystore.bin");
		parseSecret(getCGNData(keyPath, alias, key));

	}

	private Key loadKeys(String location) throws Exception {
		File file = null;
		Key key = null;
		KeyStore ks = null;
		char[] pass = null;
		InputStream is = null;
		try {
			file = new File(location);
			if (!file.exists()) {
				throw new Exception("Keystore File Not Found in dir Path :: " + location);
			}
			ks = KeyStore.getInstance("JCEKS");
			pass = getCharArray("password");
			is = new FileInputStream(file);
			ks.load(is, pass);
			key = ks.getKey("pgkey", pass);
			return key;
		} catch (Exception e) {
			throw e;
		}
	}

	private char[] getCharArray(String str) {
		return (str != null) && (!str.equalsIgnoreCase("")) ? str.toCharArray() : null;
	}

	private String getCGNData(String resourcePath, String aliasName, Key key) throws Exception {
		byte[] xmlData = null;
		byte[] decryptedText = null;
		try {
			createCGZFileFromCGN(resourcePath, key);
			xmlData = extractZIPAndReadXML(aliasName + ".xml", resourcePath);
			if (xmlData == null)
				throw new Exception("Alias Name does not Exits in the resource file aliasName :: " + aliasName);

			decryptedText = decrypt(xmlData, key);
			if (decryptedText != null) {
				deleteFile(resourcePath + File.separator + "resource.cgz");
			}
			return new String(decryptedText);
		} catch (Exception e) {
			throw e;
		}
	}

	private void createCGZFileFromCGN(String resourcePath, Key key) throws Exception {
		File cgzFile = null;
		File cgnFile = null;
		BufferedInputStream data = null;
		byte[] decryptedCgnFileData = null;
		OutputStream os = null;
		try {
			cgzFile = new File(resourcePath + File.separator + "resource.cgz");
			if (!cgzFile.exists())
				cgzFile.createNewFile();
			cgnFile = new File(resourcePath + File.separator + "resource.cgn");
			if (!cgnFile.exists()) {
				throw new Exception("Resource File not found in the dir path :: " + cgnFile.getAbsolutePath());
			}
			data = new BufferedInputStream(new FileInputStream(cgnFile));
			int cgnFileLength = (int) cgnFile.length();
			byte[] cgnFileData = new byte[cgnFileLength];
			while (data.read(cgnFileData) != -1)
				;
			decryptedCgnFileData = decrypt(cgnFileData, key);
			os = new FileOutputStream(cgzFile);
			os.write(decryptedCgnFileData);
			os.flush();
			os.close();
			data.close();
		} catch (Exception e) {
			throw e;
		} finally {
			cgzFile = null;
			cgnFile = null;
			data = null;
			decryptedCgnFileData = null;
			os = null;
		}
	}

	private byte[] extractZIPAndReadXML(String entryName, String resourcePath) throws IOException {
		ZipFile zipFile = null;
		ByteArrayOutputStream os = null;
		ZipEntry entry = null;
		try {
			os = new ByteArrayOutputStream();
			zipFile = new ZipFile(resourcePath + File.separator + "resource.cgz");
			entry = zipFile.getEntry(entryName);
			if (entry != null) {
				InputStream is = zipFile.getInputStream(entry);
				copyInputStream(is, os);
			}
			zipFile.close();
			byte[] arrayOfByte = os.toByteArray();
			return arrayOfByte;
		} catch (IOException ioe) {
			throw ioe;
		} finally {
			zipFile = null;
			os = null;
			entry = null;
		}

	}

	private final void copyInputStream(InputStream in, OutputStream out) throws IOException {
		byte[] buffer = new byte[1024];
		int len;
		while ((len = in.read(buffer)) >= 0) {
			out.write(buffer, 0, len);
		}
		in.close();
		out.close();
	}

	private byte[] decrypt(byte[] cipherText, Key key) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, ShortBufferException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = null;
		try {
			cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
			cipher.init(2, key);
			int plainTextLength = cipher.getOutputSize(cipherText.length);
			byte[] tmpPlainText = new byte[plainTextLength];
			int ptLength = cipher.update(cipherText, 0, cipherText.length, tmpPlainText, 0);
			ptLength += cipher.doFinal(tmpPlainText, ptLength);
			byte[] plainText = new byte[ptLength];
			System.arraycopy(tmpPlainText, 0, plainText, 0, ptLength);
			byte[] arrayOfByte1 = plainText;
			return arrayOfByte1;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			cipher = null;
		}
	}

	private void deleteFile(String filePath) {
		File file = new File(filePath);
		file.delete();
	}

	private void parseSecret(String xml) {
		String startTag = "<terminal>";
		String endTag = "</terminal>";
		int startIndex = 0;
		while ((startIndex = xml.indexOf(startTag, startIndex)) != -1) {
			int endIndex = xml.indexOf(endTag, startIndex);
			if (endIndex == -1)
				break;
			String content = xml.substring(startIndex + startTag.length(), endIndex).trim();
			this.id = getTagContent(content, "id");
			this.password = getTagContent(content, "password");
			this.key = getTagContent(content, "resourceKey");
			String webAddr = getTagContent(content, "webaddress"); 
			this.webAddress = webAddr.endsWith("/") ? webAddr : webAddr.concat("/");
			break;
		}
	}

	private String getTagContent(String content, String tagName) {
		String startTag = "<" + tagName + ">";
		String endTag = "</" + tagName + ">";
		int startIndex = content.indexOf(startTag);
		int endIndex = content.indexOf(endTag);
		if (startIndex == -1 || endIndex == -1) {
			return null;
		}
		return content.substring(startIndex + startTag.length(), endIndex).trim();
	}
}
