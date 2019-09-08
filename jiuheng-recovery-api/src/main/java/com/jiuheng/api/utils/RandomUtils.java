package com.jiuheng.api.utils;

import java.nio.ByteBuffer;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class RandomUtils {

	/**
	 * 随机字符串
	 */
	private static final String SOURCE = "0123456789ABCDEFGHJKLMNPQRSTUWXY";
	/**
	 * 纯数字长度
	 */
	private static final int DIGIT_LENGTH = 10;
	/**
	 * 十六进制长度
	 */
	private static final int HEX_LENGTH = 16;
	/**
	 * BASE32随机长度
	 */
	private static final int BASE32_LENGTH = 32;

	/**
	 * 安全随机数生成器
	 */
	private static SecureRandom rand = new SecureRandom();;

	/**
	 * 线程本地StringBuilder
	 */
	private final static ThreadLocal<StringBuilder> threadSafeStringBuilder = new ThreadLocal<StringBuilder>() {

		@Override
		protected StringBuilder initialValue() {
			return new StringBuilder(48);
		}

	};

	public final static int searchIndex(char ch) {
		int index = ch - 48;
		if (index > 38) {
			index = ch - 58;
		} else if (index > 31) {
			index = ch - 57;
		} else if (index > 25) {
			index = ch - 56;
		} else if (index > 9) {
			index = ch - 55;
		}
		return index;
	}

	/**
	 * @param builder
	 * @param offset
	 * @param length
	 * @return
	 */
	public static final StringBuilder randomBase32(StringBuilder builder, int offset, int length) {
		for (int i = 0; i < length; i++) {
			int index = rand.nextInt(BASE32_LENGTH);
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		return builder;
	}

	/**
	 * @param length
	 * @return
	 */
	public static final String randomBase32(int length) {
		StringBuilder builder = threadSafeStringBuilder.get();
		builder.delete(0, builder.capacity());
		return randomBase32(builder, 0, length).toString();
	}

	/**
	 * @param builder
	 * @param offset
	 * @param length
	 * @return
	 */
	public static final StringBuilder randomBase32ExcludeCode(StringBuilder builder, int offset, int length,
			char[] exclude) {
		int end = exclude.length > length ? length : exclude.length;
		for (int i = 0; i < end; i++) {
			int index = (searchIndex(exclude[i]) + rand.nextInt(BASE32_LENGTH - 1) + 1) % BASE32_LENGTH;
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		for (int i = end; i < length; i++) {
			int index = rand.nextInt(BASE32_LENGTH);
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		return builder;
	}

	/**
	 * @param length
	 * @return
	 */
	public final static String randomBase32ExcludeCode(int length, char[] exclude) {
		StringBuilder builder = threadSafeStringBuilder.get();
		builder.delete(0, builder.capacity());
		return randomBase32ExcludeCode(builder, 0, length, exclude).toString();
	}

	/**
	 * @param builder
	 * @param offset
	 * @param length
	 * @return
	 */
	public static final StringBuilder randomHex(StringBuilder builder, int offset, int length) {
		for (int i = 0; i < length; i++) {
			int index = rand.nextInt(HEX_LENGTH);
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		return builder;
	}

	/**
	 * @param length
	 * @return
	 */
	public final static String randomHex(int length) {
		StringBuilder builder = threadSafeStringBuilder.get();
		builder.delete(0, builder.capacity());
		return randomHex(builder, 0, length).toString();
	}

	/**
	 * @param builder
	 * @param offset
	 * @param length
	 * @return
	 */
	public static final StringBuilder randomHexExcludeCode(StringBuilder builder, int offset, int length,
			char[] exclude) {
		int end = exclude.length > length ? length : exclude.length;
		for (int i = 0; i < end; i++) {
			int index = (searchIndex(exclude[i]) + rand.nextInt(HEX_LENGTH - 1) + 1) % HEX_LENGTH;
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		for (int i = end; i < length; i++) {
			int index = rand.nextInt(HEX_LENGTH);
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		return builder;
	}

	/**
	 * @param length
	 * @return
	 */
	public final static String randomHexExcludeCode(int length, char[] exclude) {
		StringBuilder builder = threadSafeStringBuilder.get();
		builder.delete(0, builder.capacity());
		return randomHexExcludeCode(builder, 0, length, exclude).toString();
	}

	/**
	 * @param builder
	 * @param offset
	 * @param length
	 * @return
	 */
	public static final StringBuilder randomDigit(StringBuilder builder, int offset, int length) {
		for (int i = 0; i < length; i++) {
			int index = rand.nextInt(DIGIT_LENGTH);
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		return builder;
	}

	/**
	 * @param length
	 * @return
	 */
	public final static String randomDigit(int length) {
		StringBuilder builder = threadSafeStringBuilder.get();
		builder.delete(0, builder.capacity());
		return randomDigit(builder, 0, length).toString();
	}

	/**
	 * @param builder
	 * @param offset
	 * @param length
	 * @return
	 */
	public static final StringBuilder randomDigitExcludeCode(StringBuilder builder, int offset, int length,
			char[] exclude) {
		int end = exclude.length > length ? length : exclude.length;
		for (int i = 0; i < end; i++) {
			int index = (searchIndex(exclude[i]) + rand.nextInt(DIGIT_LENGTH - 1) + 1) % DIGIT_LENGTH;
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		for (int i = end; i < length; i++) {
			int index = rand.nextInt(DIGIT_LENGTH);
			builder.insert(offset + i, SOURCE.charAt(index));
		}
		return builder;
	}

	/**
	 * @param length
	 * @return
	 */
	public final static String randomDigitExcludeCode(int length, char[] exclude) {
		StringBuilder builder = threadSafeStringBuilder.get();
		builder.delete(0, builder.capacity());
		return randomDigitExcludeCode(builder, 0, length, exclude).toString();
	}

	/**
	 * @param bytes
	 * @return
	 */
	public final static String toHexString(byte[] bytes) {
		StringBuilder builder = threadSafeStringBuilder.get();
		builder.delete(0, builder.capacity());
		for (byte b : bytes) {
			int v = b & 0xff;
			builder.append(SOURCE.charAt((v >>> 4)));
			builder.append(SOURCE.charAt((v & 0xF)));
		}
		return builder.toString();
	}

	/**
	 * @return
	 */
	public final static String randomUniqueToken() {
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
			ByteBuffer buffer = ByteBuffer.allocate(20);
			long curTime = System.currentTimeMillis();
			buffer.putLong(curTime);
			buffer.putLong(System.nanoTime());
			buffer.putInt(rand.nextInt());
			buffer.flip();
			byte[] md5 = messageDigest.digest(buffer.array());
			return RandomUtils.toHexString(md5);
		} catch (NoSuchAlgorithmException e) {
			return "";
		}
	}
}