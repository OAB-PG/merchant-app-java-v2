package com.oab.ipay.key;

import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.Security;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONArray;
import org.json.JSONObject;

import com.oab.ipay.avail.JsonUtil;
import com.oab.ipay.vo.Reply;
import com.oab.ipay.vo.Request;
import com.oab.ipay.vo.SplitPaymentPayload;

import cryptix.provider.Cryptix;
import cryptix.provider.key.RawSecretKey;
import cryptix.util.core.Hex;


public class SecretUtil {

	static xjava.security.Cipher des = null;
	static RawSecretKey desKey = null;
	static RawSecretKey localMasterKey = null;
	static byte[] md5key;

	private static final List<String> VALID_RESULTS = Arrays.asList(
		    "CAPTURED", "NOT CAPTURED", "SUCCESS", "APPROVED", "NOT APPROVED"
		);
	
	public static String encrypt(final Request object, final String key) throws Exception {
		try {
			byte[] keyBytes = key.getBytes(StandardCharsets.UTF_8);
			if (keyBytes.length == 16) {
				keyBytes = Arrays.copyOf(keyBytes, 24);
				System.arraycopy(keyBytes, 0, keyBytes, 16, 8); // Repeat the first 8 bytes
			}
			if (keyBytes.length != 24) {
				throw new InvalidKeyException("Invalid key size for 3DES. Key must be 16 or 24 bytes.");
			}
			Cipher des = Cipher.getInstance("DESede/ECB/PKCS5Padding");
			SecretKeySpec desKey = new SecretKeySpec(keyBytes, "DESede");
			des.init(Cipher.ENCRYPT_MODE, desKey);
			JSONObject json = JsonUtil.objectToJson(object);
			System.out.println(json.toString());
			byte[] plaintextBytes = json.toString().getBytes(StandardCharsets.UTF_8);
			byte[] ciphertext = des.doFinal(plaintextBytes);
			return byteArrayToHex(ciphertext);
		} catch (Exception e) {
			throw new Exception("Error during encryption", e);
		}
	}

	public static Reply decrypt(String key, String value) throws Exception {
		Security.addProvider(new Cryptix());
		String key1 = alpha2Hex(key.substring(0, 8));
		String key2 = alpha2Hex(key.substring(8, 16));
		String key3 = alpha2Hex(key.substring(16, 24));
		String decryptedStr = hexToString(getTripleDesValue(value, key3, key2, key1));
		return parseReply(decryptedStr);
	}

	public static String decryptText(String key, String valueToBeDecrypted) throws Exception {
		String key1 = null;
		String key2 = null;
		String key3 = null;
		String decryptedStr = null;
		try {
			key1 = alpha2Hex(key.substring(0, 8));
			key2 = alpha2Hex(key.substring(8, 16));
			key3 = alpha2Hex(key.substring(16, 24));
			decryptedStr = getTripleDesValue(valueToBeDecrypted, key3, key2, key1);
			decryptedStr = hexToString(decryptedStr);
			return decryptedStr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			key1 = null;
			key2 = null;
			key3 = null;
		}
	}
	
	public static String hexToString(String txtInHex) {
		byte[] txtInByte = new byte[txtInHex.length() / 2];
		int j = 0;
		for (int i = 0; i < txtInHex.length(); i += 2) {
			txtInByte[j++] = Byte.parseByte(txtInHex.substring(i, i + 2), 16);
		}
		return new String(txtInByte);
	}

	public static String alpha2Hex(String data) {
		char[] alpha = data.toCharArray();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < alpha.length; i++) {
			int count = Integer.toHexString(alpha[i]).toUpperCase().length();
			if (count <= 1) {
				sb.append("0").append(Integer.toHexString(alpha[i]).toUpperCase());
			} else {
				sb.append(Integer.toHexString(alpha[i]).toUpperCase());
			}
		}
		return sb.toString();
	}


    public static String getTripleDesValue(final String pin, final String key1, final String key2, final String key3) throws Exception {
    	String decryptedKey= null;
    	try {
    		decryptedKey= getDexValue(pin, key1);
    		decryptedKey = binary2hex(asciiChar2binary(decryptedKey)).toUpperCase();
    		decryptedKey = getHexValue(decryptedKey, key2);
    		decryptedKey = getDexValue(decryptedKey, key3);
    		decryptedKey = binary2hex(asciiChar2binary(decryptedKey)).toUpperCase();
    	} catch (final Exception e) {
    		e.printStackTrace();
    	}
    	return decryptedKey;
    }

    public static String getDexValue(final String pin, final String key) throws Exception {
    	try {
    		des = xjava.security.Cipher.getInstance("DES/ECB/NONE", "Cryptix");
			desKey = new RawSecretKey("DES", Hex.fromString(key));
			des.initDecrypt(desKey);
			final byte[] pinInByteArray = Hex.fromString(pin);
			final byte[] ciphertext = des.crypt(pinInByteArray);
			return toString(ciphertext);
		} catch (final Exception e) {
			throw e;
		}
    }
    
    public static String getHexValue(final String pin, final String key) throws Exception {
    	try {
    		des = xjava.security.Cipher.getInstance("DES/ECB/NONE", "Cryptix");
    		desKey = new RawSecretKey("DES", Hex.fromString(key));
    		des.initEncrypt(desKey);
    		final byte[] pinInByteArray = Hex.fromString(pin);
    		final byte[] ciphertext = des.crypt(pinInByteArray);
    		return (Hex.toString(ciphertext));
    	} catch (final Exception e) {
    		throw e;
    	}
    }
    
    public static String toString(final byte[] temp) {
    	final char ch[] = new char[temp.length];
    	for (int i = 0; i < temp.length; i++) {
    	    ch[i] = (char) temp[i];
    	}
    	final String s = new String(ch);
    	return s;
    }
    
    public static String rightPadZeros(String Str) {
        if(null == Str){
                return null;
        }
        String PadStr = new String (Str);
      
        for (int i = Str.length ();(i%8)!=0; i++) {
            PadStr = PadStr + '^';
        }
        return PadStr;
    }

	private static String byteArrayToHex(byte[] bytes) {
		StringBuilder hexString = new StringBuilder(2 * bytes.length);
		for (byte b : bytes) {
			hexString.append(String.format("%02X", b));
		}
		return hexString.toString();
	}

    public static String binary2hex(final String binaryString) {
		if (binaryString == null) {
			return null;
		}
		String hexString = "";
		for (int i = 0; i < binaryString.length(); i += 8) {
			String temp = binaryString.substring(i, i + 8);
			int intValue = 0;
			for (int k = 0, j = temp.length() - 1; j >= 0; j--, k++) {
			intValue += Integer.parseInt("" + temp.charAt(j))
			* Math.pow(2, k);

			}
			temp = "0" + Integer.toHexString(intValue);
			hexString += temp.substring(temp.length() - 2);

		}
		return hexString;
    }

	public static String asciiChar2binary(final String asciiString) {
		String binaryString = null;
		String temp = null;
		try {
			if (asciiString == null) {
				return null;
			}
			binaryString = "";
			temp = "";
			int intValue = 0;
			for (int i = 0; i < asciiString.length(); i++) {
				intValue = (int) asciiString.charAt(i);
				temp = "00000000" + Integer.toBinaryString(intValue);
				binaryString += temp.substring(temp.length() - 8);
			}
			return binaryString;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			binaryString = null;
			temp = null;
		}

	}

    public static Reply parseReply(String response) throws Exception {
    	JSONObject json = new JSONObject(response);
        Reply reply = new Reply();
        reply.setResult(json.optString("result"));
        reply.setPaymentId(json.optString("paymentid"));
        reply.setTranId(json.optString("tranid"));
        reply.setRef(json.optString("ref"));
        reply.setAmt(json.optString("amt"));
        reply.setAuth(json.optString("auth"));
        reply.setDate(json.optString("date"));
        reply.setUdf1(json.optString("udf1"));
        reply.setUdf2(json.optString("udf2"));
        reply.setUdf3(json.optString("udf3"));
        reply.setUdf4(json.optString("udf4"));
        reply.setUdf5(json.optString("udf5"));
        reply.setUdf5(json.optString("udf5"));
        reply.setTranResponseDate(json.optString("tranResponseDate"));
        reply.setTranRequestDate(json.optString("tranRequestDate"));
        reply.setTranDate(json.optString("tranDate"));
        if(json.optString("tokencustid") == null) {
            reply.setTokenNo(json.optString("custid"));
        } else {
        	reply.setTokenNo(json.optString("tokencustid"));	
        }
        if(json.optString("trackid") == null) {
            reply.setTrackId(json.optString("trackId"));
        } else {
        	reply.setTrackId(json.optString("trackid"));	
        }
        JSONArray jsonArray = json.optJSONArray("splitPaymentPayload");
        if(jsonArray != null) {
        	SplitPaymentPayload splitPayLoad = null;
        	for (int i = 0; i < jsonArray.length(); i++) {
        		splitPayLoad = new SplitPaymentPayload();
        		JSONObject responseObj = (JSONObject)jsonArray.get(i);
        		splitPayLoad.setAliasName(responseObj.optString("aliasName"));
        		splitPayLoad.setReference(responseObj.optString("reference"));
        		splitPayLoad.setNotes(responseObj.optString("notes"));
        		splitPayLoad.setSplitAmount(responseObj.optString("splitAmount"));
        		splitPayLoad.setSplitTranId(responseObj.optString("splitTranId"));
        		splitPayLoad.setType(responseObj.optString("type"));
        		reply.addSplitPaymentPayload(splitPayLoad);
			}
        }
        if (!VALID_RESULTS.contains(json.optString("result"))) {
            String error = Stream.of("Error", "ErrorText", "error_text", "error_code_tag")
                .map(json::optString)
                .filter(e -> e != null && !e.trim().isEmpty())
                .findFirst()
                .orElse(null);
            reply.setError(error);
            reply.setErrorText(error);
        }
        return reply;
    }

}
