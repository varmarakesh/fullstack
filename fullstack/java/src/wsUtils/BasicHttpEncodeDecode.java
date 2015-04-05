package wsUtils;

import org.apache.commons.codec.binary.Base64;

public class BasicHttpEncodeDecode{

	private static String[] decode(final String encodedString) {
		final byte[] decodedBytes = Base64.decodeBase64(encodedString.getBytes());
		final String pair = new String(decodedBytes);
		final String[] userDetails = pair.split(":", 2);
		return userDetails;
	}

	private static String createEncodedText(final String username, final String password) {
		final String pair = username + ":" + password;
		final byte[] encodedBytes = Base64.encodeBase64(pair.getBytes());
		return new String(encodedBytes);
	}
	public static void main(String[] args) {

		final String username = "Aladdin";
		final String password = "open sesame";

		System.out.println("Input\t: username [" + username + "], password [" + password + "]");

		final String encodedText = createEncodedText(username, password);
		System.out.println("Encoded Text : " + encodedText);

		String text = "c2VydmljZV9haGZjX2RlYWxlcnRyYWNrX2RldjpFeHBlcnRAOA==";
		final String[] userDetails = decode(text);
		System.out.println("Decoded\t: username [" + userDetails[0] + "], password [" +  userDetails[1] + "]");

	}


}