package com.jiuheng.api.utils;

import com.jiuheng.service.dto.UserLoginInfo;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

public class CookieCode {

	private final static MessageDigest getInstance() {
		try {
			return MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}

	public final static String encode(long member, long rand, long timestamp) {
		byte[] mix = new byte[24];

		for (int i = 0; i < 8; i++) {
			mix[i * 3] = (byte) (0xFF & timestamp);
			mix[i * 3 + 1] = (byte) (0xFF & rand);
			mix[i * 3 + 2] = (byte) (0xFF & member);
			member >>= 8;
			rand >>= 8;
			timestamp >>= 8;
		}

		MessageDigest messageDigest = CookieCode.getInstance();
		byte[] digest = messageDigest.digest(mix);

		int index = (0xFF & mix[0]) / 10;
		index = index == 0 ? 8 : index;
		index = index >= 24 ? 16 : index;
		byte[] output = new byte[40];
		System.arraycopy(mix, 0, output, 0, index);
		System.arraycopy(digest, 0, output, index, 16);
		System.arraycopy(mix, index, output, index + 16, 24 - index);

		return Base32.encodeBytesToBase32(output, 0, output.length);
	}

	public final static UserLoginInfo decode(String str) {
		long member = 0L, rand = 0L, timestamp = 0L;
		byte[] digest = new byte[16];
		byte[] mix = new byte[24];

		byte[] data = Base32.decodeBase32ToBytes(str);
		if (data != null && data.length == 40) {
			int index = (0xFF & data[0]) / 10;
			index = index == 0 ? 8 : index;
			index = index >= 24 ? 16 : index;
			System.arraycopy(data, 0, mix, 0, index);
			System.arraycopy(data, index, digest, 0, 16);
			System.arraycopy(data, index + 16, mix, index, 24 - index);

			MessageDigest messageDigest = CookieCode.getInstance();
			byte[] cal = messageDigest.digest(mix);

			if (Arrays.equals(digest, cal)) {
				for (int i = 7; i >= 0; i--) {
					member <<= 8;
					rand <<= 8;
					timestamp <<= 8;
					timestamp |= 0xFF & mix[i * 3];
					rand |= 0xFF & mix[i * 3 + 1];
					member |= 0xFF & mix[i * 3 + 2];
				}
			}
		}
		return new UserLoginInfo(member, rand, timestamp);
	}
}
